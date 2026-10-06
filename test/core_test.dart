import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_chat_bot_app/coach/coach_models.dart';
import 'package:ai_chat_bot_app/coach/coach_service.dart';
import 'package:ai_chat_bot_app/core/app_settings.dart';
import 'package:ai_chat_bot_app/core/progress_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

SessionRecord _record(DateTime date, {int score = 80, int messages = 5}) => SessionRecord(
  id: '${date.microsecondsSinceEpoch}',
  date: date,
  roomId: 'travel',
  scenario: 'Airport check-in',
  practiceLang: 'en',
  level: 'beginner',
  score: score,
  messages: messages,
);

const _setup = SessionSetup(
  room: CoachRoom.interview,
  scenario: 'Product Manager',
  scenarioLabel: 'Product Manager',
  level: 'intermediate',
  practiceLang: 'es',
);

void main() {
  group('ProgressStore streaks', () {
    late DateTime now;
    late ProgressStore store;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      now = DateTime(2026, 10, 6, 15);
      store = ProgressStore.forTest(now: () => now);
      await store.load();
    });

    test('starts empty', () {
      expect(store.currentStreak, 0);
      expect(store.bestStreak, 0);
      expect(store.practicedToday, isFalse);
      expect(store.averageScore, 0);
      expect(store.lastWeek, everyElement(isFalse));
    });

    test('counts consecutive days and keeps a streak alive until the day ends', () async {
      await store.add(_record(DateTime(2026, 10, 4, 9)));
      await store.add(_record(DateTime(2026, 10, 5, 20)));
      // practised yesterday but not yet today: the streak is still alive
      expect(store.currentStreak, 2);
      expect(store.practicedToday, isFalse);
      await store.add(_record(DateTime(2026, 10, 6, 8)));
      expect(store.currentStreak, 3);
      expect(store.practicedToday, isTrue);
      expect(store.lastWeek, [false, false, false, false, true, true, true]);
    });

    test('a missed day resets the streak but keeps the best one', () async {
      await store.add(_record(DateTime(2026, 10, 1)));
      await store.add(_record(DateTime(2026, 10, 2)));
      await store.add(_record(DateTime(2026, 10, 3)));
      await store.add(_record(DateTime(2026, 10, 6)));
      expect(store.currentStreak, 1);
      expect(store.bestStreak, 3);
    });

    test('several sessions on one day count once', () async {
      await store.add(_record(DateTime(2026, 10, 6, 8)));
      await store.add(_record(DateTime(2026, 10, 6, 18)));
      expect(store.currentStreak, 1);
      expect(store.totalSessions, 2);
    });

    test('stats and persistence across a reload', () async {
      await store.add(_record(DateTime(2026, 10, 5), score: 60, messages: 4));
      await store.add(_record(DateTime(2026, 10, 6), score: 90, messages: 6));
      expect(store.averageScore, 75);
      expect(store.bestScore, 90);
      expect(store.totalMessages, 10);

      final reloaded = ProgressStore.forTest(now: () => now);
      await reloaded.load();
      expect(reloaded.totalSessions, 2);
      expect(reloaded.sessions.first.score, 90); // newest first
      await reloaded.clear();
      expect(reloaded.currentStreak, 0);
    });
  });

  group('AppSettings', () {
    test('defaults: English app, English practice, system theme', () async {
      SharedPreferences.setMockInitialValues({});
      final s = AppSettings.forTest();
      await s.load();
      expect(s.uiLang, 'en');
      expect(s.practiceLang, 'en');
      expect(s.themeMode, ThemeMode.system);
      expect(s.level, 'intermediate');
      expect(s.autoSpeak, isTrue);
      expect(s.isGuest, isFalse);
    });

    test('saves choices and ignores unknown values', () async {
      SharedPreferences.setMockInitialValues({'ui_lang': 'xx', 'level': 'god'});
      final s = AppSettings.forTest();
      await s.load();
      expect(s.uiLang, 'en');
      expect(s.level, 'intermediate');

      await s.setUiLang('hi');
      await s.setThemeMode(ThemeMode.dark);
      await s.setAccent('teal');
      await s.setGuest(true, name: 'Asha');

      final again = AppSettings.forTest();
      await again.load();
      expect(again.uiLang, 'hi');
      expect(again.themeMode, ThemeMode.dark);
      expect(again.accentId, 'teal');
      expect(again.isGuest, isTrue);
      expect(again.guestName, 'Asha');
    });
  });

  group('CoachService', () {
    http.Response ok(Object body) => http.Response(jsonEncode(body), 200, headers: {'content-type': 'application/json'});

    test('sends the whole conversation and parses the reply', () async {
      late http.Request seen;
      final service = CoachService(
        url: 'https://example.test/coach',
        client: MockClient((req) async {
          seen = req;
          return ok({
            'reply': 'Hola, ¿qué tal?',
            'reply_translation': 'Hi, how are you?',
            'feedback': {'corrected': 'Quiero un café.', 'explanation': 'x', 'tip': 'y', 'score': 64},
            'suggestions': ['Bien', '', 'Muy bien'],
          });
        }),
      );
      final reply = await service.reply(
        setup: _setup,
        uiLang: 'hi',
        messages: [CoachMessage(fromCoach: true, text: 'Hola'), CoachMessage(fromCoach: false, text: 'Quiero café')],
      );

      expect(reply.reply, 'Hola, ¿qué tal?');
      expect(reply.translation, 'Hi, how are you?');
      expect(reply.feedback.hasCorrection, isTrue);
      expect(reply.feedback.score, 64);
      expect(reply.suggestions, ['Bien', 'Muy bien']);

      final body = jsonDecode(seen.body) as Map<String, dynamic>;
      expect(body['action'], 'reply');
      expect(body['mode'], 'interview');
      expect(body['scenario'], 'Product Manager');
      expect(body['practiceLang'], 'es');
      expect(body['uiLang'], 'hi');
      expect(body['messages'], [
        {'role': 'coach', 'text': 'Hola'},
        {'role': 'user', 'text': 'Quiero café'},
      ]);
      expect(body.containsKey('image'), isFalse);
      // nothing secret travels with the request
      expect(seen.headers.keys.map((k) => k.toLowerCase()), isNot(contains('x-goog-api-key')));
      expect(seen.headers.keys.map((k) => k.toLowerCase()), isNot(contains('authorization')));
    });

    test('attaches the photo for Picture Talk', () async {
      late Map<String, dynamic> body;
      final service = CoachService(
        url: 'https://example.test/coach',
        client: MockClient((req) async {
          body = jsonDecode(req.body) as Map<String, dynamic>;
          return ok({'reply': 'What do you see?', 'reply_translation': '', 'feedback': {}, 'suggestions': []});
        }),
      );
      await service.reply(
        setup: SessionSetup(
          room: CoachRoom.picture,
          scenario: '',
          scenarioLabel: '',
          level: 'beginner',
          practiceLang: 'en',
          photo: PhotoAttachment(mimeType: 'image/jpeg', base64Data: 'AAAA', bytes: Uint8List(0)),
        ),
        uiLang: 'en',
        messages: const [],
      );
      expect(body['image'], 'AAAA');
      expect(body['mimeType'], 'image/jpeg');
    });

    test('parses the summary', () async {
      final service = CoachService(
        url: 'https://example.test/coach',
        client: MockClient(
          (req) async => ok({
            'overall_score': 81,
            'summary': 'Nice!',
            'strengths': ['Clear'],
            'improvements': ['Articles'],
            'vocabulary': [
              {'word': 'billete', 'meaning': 'ticket'},
              {'word': '', 'meaning': 'dropped'},
            ],
            'next_goal': 'Past tense',
          }),
        ),
      );
      final s = await service.summary(setup: _setup, uiLang: 'en', messages: [CoachMessage(fromCoach: false, text: 'hi')]);
      expect(s.overallScore, 81);
      expect(s.vocabulary.map((v) => v.word), ['billete']);
      expect(s.nextGoal, 'Past tense');
    });

    test('maps failures to friendly error kinds', () async {
      Future<CoachErrorKind> kindFor(MockClient client) async {
        try {
          await CoachService(url: 'https://example.test/coach', client: client).reply(
            setup: _setup,
            uiLang: 'en',
            messages: const [],
          );
        } on CoachException catch (e) {
          return e.kind;
        }
        fail('expected a CoachException');
      }

      expect(await kindFor(MockClient((_) async => http.Response('{}', 429))), CoachErrorKind.busy);
      expect(await kindFor(MockClient((_) async => http.Response('{}', 504))), CoachErrorKind.timeout);
      expect(await kindFor(MockClient((_) async => http.Response('{}', 413))), CoachErrorKind.tooLarge);
      expect(await kindFor(MockClient((_) async => http.Response('oops', 500))), CoachErrorKind.server);
      expect(await kindFor(MockClient((_) async => http.Response('not json', 200))), CoachErrorKind.server);
      expect(await kindFor(MockClient((_) async => throw http.ClientException('offline'))), CoachErrorKind.network);
    });
  });

  group('Translations', () {
    final dir = Directory('lib/l10n');
    final langs = ['en', 'hi', 'es', 'fr', 'zh'];
    Map<String, dynamic> load(String lang) =>
        jsonDecode(File('${dir.path}/app_$lang.arb').readAsStringSync()) as Map<String, dynamic>;

    test('every language has exactly the same keys as English', () {
      final en = load('en').keys.where((k) => !k.startsWith('@')).toSet();
      for (final lang in langs.skip(1)) {
        final keys = load(lang).keys.where((k) => !k.startsWith('@')).toSet();
        expect(keys.difference(en), isEmpty, reason: '$lang has extra keys');
        expect(en.difference(keys), isEmpty, reason: '$lang is missing keys');
      }
    });

    test('placeholders match the English text and nothing is empty', () {
      final placeholder = RegExp(r'\{(name|count|email)[,}]');
      final en = load('en');
      for (final lang in langs) {
        final arb = load(lang);
        for (final key in en.keys.where((k) => !k.startsWith('@'))) {
          final text = arb[key] as String;
          expect(text.trim(), isNotEmpty, reason: '$lang.$key is empty');
          if (lang == 'en') continue;
          final want = placeholder.allMatches(en[key] as String).map((m) => m.group(1)).toSet();
          final got = placeholder.allMatches(text).map((m) => m.group(1)).toSet();
          expect(got, want, reason: '$lang.$key placeholders differ');
        }
      }
    });
  });
}
