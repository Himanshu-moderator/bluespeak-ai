import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One finished practice session, saved on the device.
class SessionRecord {
  final String id;
  final DateTime date;
  final String roomId;
  final String scenario;
  final String practiceLang;
  final String level;
  final int score;
  final int messages;
  final String summary;

  const SessionRecord({
    required this.id,
    required this.date,
    required this.roomId,
    required this.scenario,
    required this.practiceLang,
    required this.level,
    required this.score,
    required this.messages,
    this.summary = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'room': roomId,
    'scenario': scenario,
    'lang': practiceLang,
    'level': level,
    'score': score,
    'messages': messages,
    'summary': summary,
  };

  factory SessionRecord.fromJson(Map<String, dynamic> j) => SessionRecord(
    id: '${j['id']}',
    date: DateTime.tryParse('${j['date']}') ?? DateTime.now(),
    roomId: '${j['room']}',
    scenario: '${j['scenario'] ?? ''}',
    practiceLang: '${j['lang'] ?? 'en'}',
    level: '${j['level'] ?? 'intermediate'}',
    score: (j['score'] as num?)?.toInt() ?? 0,
    messages: (j['messages'] as num?)?.toInt() ?? 0,
    summary: '${j['summary'] ?? ''}',
  );
}

/// Streaks and history, kept on the device.
class ProgressStore extends ChangeNotifier {
  ProgressStore._() : _now = DateTime.now;

  static final ProgressStore instance = ProgressStore._();

  /// For tests: an isolated store with a controllable clock.
  ProgressStore.forTest({DateTime Function()? now}) : _now = now ?? DateTime.now;

  static const _key = 'sessions_v1';
  static const _maxSessions = 80;

  final DateTime Function() _now;
  SharedPreferences? _prefs;
  List<SessionRecord> _sessions = [];

  /// Newest first.
  List<SessionRecord> get sessions => List.unmodifiable(_sessions);

  Future<void> load() async {
    final p = _prefs = await SharedPreferences.getInstance();
    final raw = p.getString(_key);
    if (raw == null) return;
    try {
      final list = jsonDecode(raw) as List;
      _sessions = list
          .map((e) => SessionRecord.fromJson(e as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    } catch (_) {
      _sessions = [];
    }
  }

  Future<void> add(SessionRecord record) async {
    _sessions = [record, ..._sessions].take(_maxSessions).toList();
    notifyListeners();
    await _prefs?.setString(
      _key,
      jsonEncode(_sessions.map((s) => s.toJson()).toList()),
    );
  }

  Future<void> clear() async {
    _sessions = [];
    notifyListeners();
    await _prefs?.remove(_key);
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  Set<DateTime> get _practiceDays => _sessions.map((s) => _day(s.date)).toSet();

  bool get practicedToday => _practiceDays.contains(_day(_now()));

  /// Consecutive days with a session, counting back from today. A streak is still
  /// alive if you practised yesterday but not yet today.
  int get currentStreak {
    final days = _practiceDays;
    var cursor = _day(_now());
    if (!days.contains(cursor)) cursor = cursor.subtract(const Duration(days: 1));
    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
    }
    return streak;
  }

  int get bestStreak {
    final days = _practiceDays.toList()..sort();
    var best = 0, run = 0;
    DateTime? prev;
    for (final d in days) {
      run = prev != null && d.difference(prev).inDays == 1 ? run + 1 : 1;
      if (run > best) best = run;
      prev = d;
    }
    return best;
  }

  /// The last 7 days, oldest first, true where you practised.
  List<bool> get lastWeek {
    final days = _practiceDays;
    final today = _day(_now());
    return List.generate(7, (i) {
      final d = DateTime(today.year, today.month, today.day - (6 - i));
      return days.contains(d);
    });
  }

  int get totalSessions => _sessions.length;

  int get totalMessages => _sessions.fold(0, (sum, s) => sum + s.messages);

  int get averageScore => _sessions.isEmpty
      ? 0
      : (_sessions.fold<int>(0, (sum, s) => sum + s.score) / _sessions.length)
            .round();

  int get bestScore =>
      _sessions.fold<int>(0, (best, s) => s.score > best ? s.score : best);
}
