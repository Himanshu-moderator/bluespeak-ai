import 'package:ai_chat_bot_app/coach/coach_models.dart';
import 'package:ai_chat_bot_app/coach/coach_service.dart';
import 'package:ai_chat_bot_app/core/app_settings.dart';
import 'package:ai_chat_bot_app/core/app_theme.dart';
import 'package:ai_chat_bot_app/core/languages.dart';
import 'package:ai_chat_bot_app/home_screens/practice_screen.dart';
import 'package:ai_chat_bot_app/l10n/l10n_helpers.dart';
import 'package:ai_chat_bot_app/widgets/message_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A coach that answers instantly with canned replies, so UI flows can be tested.
class FakeCoach extends CoachService {
  FakeCoach({this.failNext = false});

  bool failNext;
  final List<List<CoachMessage>> seen = [];

  @override
  Future<CoachReply> reply({
    required SessionSetup setup,
    required String uiLang,
    required List<CoachMessage> messages,
  }) async {
    seen.add(List.of(messages));
    if (failNext) {
      failNext = false;
      throw const CoachException(CoachErrorKind.busy);
    }
    if (messages.isEmpty) {
      return const CoachReply(
        reply: 'Welcome! Do you have a passport?',
        translation: '',
        feedback: CoachFeedback(),
        suggestions: ['Yes, here it is.'],
      );
    }
    return const CoachReply(
      reply: 'Great. Where are you flying to?',
      translation: '',
      feedback: CoachFeedback(
        corrected: 'I would like a window seat.',
        explanation: "Use 'would like'.",
        tip: "Say \"I'd like\".",
        score: 72,
      ),
      suggestions: ['To Delhi.'],
    );
  }
}

Widget wrap(Widget child, {Locale locale = const Locale('en')}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    theme: buildTheme(accentFor('indigo').color, Brightness.light),
    home: child,
  );
}

const _setup = SessionSetup(
  room: CoachRoom.travel,
  scenario: 'Airport check-in',
  scenarioLabel: 'Airport check-in',
  level: 'beginner',
  practiceLang: 'en',
);

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await AppSettings.instance.load();
    await AppSettings.instance.setAutoSpeak(false);
  });

  testWidgets('feedback card shows the correction, why, tip and score', (tester) async {
    await tester.pumpWidget(
      wrap(
        Scaffold(
          body: FeedbackCard(
            feedback: const CoachFeedback(
              corrected: 'I would like a window seat.',
              explanation: "Use 'would like'.",
              tip: 'Say "I\'d like".',
              score: 72,
            ),
            onListen: (_) {},
          ),
        ),
      ),
    );
    expect(find.text('Try saying it like this'), findsOneWidget);
    expect(find.text('I would like a window seat.'), findsOneWidget);
    expect(find.text('72'), findsOneWidget);
    expect(find.textContaining("Use 'would like'."), findsOneWidget);
  });

  testWidgets('a perfect sentence is celebrated instead of corrected', (tester) async {
    await tester.pumpWidget(
      wrap(
        Scaffold(
          body: FeedbackCard(feedback: const CoachFeedback(score: 95), onListen: (_) {}),
        ),
      ),
    );
    expect(find.text('Great sentence!'), findsOneWidget);
    expect(find.text('Try saying it like this'), findsNothing);
  });

  testWidgets('practice session: opener, send, feedback, suggestions', (tester) async {
    final coach = FakeCoach();
    await tester.pumpWidget(wrap(PracticeScreen(setup: _setup, service: coach)));
    await tester.pumpAndSettle();

    // the coach opens the scene
    expect(find.text('Welcome! Do you have a passport?'), findsOneWidget);
    expect(find.text('Yes, here it is.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'I want window seat');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
    await tester.pumpAndSettle();

    expect(find.text('I want window seat'), findsOneWidget);
    expect(find.text('Great. Where are you flying to?'), findsOneWidget);
    expect(find.text('I would like a window seat.'), findsOneWidget);
    expect(find.text('72'), findsOneWidget);
    // the request carried the whole conversation so far
    expect(coach.seen.last.map((m) => m.text), ['Welcome! Do you have a passport?', 'I want window seat']);
  });

  testWidgets('a failed message can be retried', (tester) async {
    final coach = FakeCoach();
    await tester.pumpWidget(wrap(PracticeScreen(setup: _setup, service: coach)));
    await tester.pumpAndSettle();

    coach.failNext = true;
    await tester.enterText(find.byType(TextField), 'Hello there');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
    await tester.pumpAndSettle();

    expect(find.text('The coach is busy. Try again in a moment.'), findsOneWidget);
    expect(find.text('Not sent. Tap to retry.'), findsOneWidget);

    await tester.tap(find.text('Not sent. Tap to retry.'));
    await tester.pumpAndSettle();
    expect(find.text('Great. Where are you flying to?'), findsOneWidget);
    expect(find.text('Not sent. Tap to retry.'), findsNothing);
  });

  testWidgets('the practice screen is translated when the app is in Hindi', (tester) async {
    await tester.pumpWidget(
      wrap(PracticeScreen(setup: _setup, service: FakeCoach()), locale: const Locale('hi')),
    );
    await tester.pumpAndSettle();
    expect(find.text('समाप्त करें'), findsOneWidget); // "Finish"
  });
}
