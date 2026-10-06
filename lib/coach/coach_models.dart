import 'dart:typed_data';

import 'package:flutter/material.dart';

/// The practice rooms a learner can pick from.
enum CoachRoom { free, interview, travel, daily, pitch, picture }

/// A situation inside a room. [prompt] is the English description sent to the coach;
/// the label shown to the learner is localised separately.
class Scenario {
  final String id;
  final String prompt;

  const Scenario(this.id, this.prompt);
}

class RoomInfo {
  final CoachRoom room;
  final IconData icon;
  final Color color;
  final List<Scenario> scenarios;

  /// Interview Prep lets the learner type the role they are applying for.
  final bool customRole;

  /// Picture Talk needs a photo to start.
  final bool needsPhoto;

  const RoomInfo({
    required this.room,
    required this.icon,
    required this.color,
    this.scenarios = const [],
    this.customRole = false,
    this.needsPhoto = false,
  });

  String get id => room.name;
}

const List<RoomInfo> rooms = [
  RoomInfo(
    room: CoachRoom.interview,
    icon: Icons.work_rounded,
    color: Color(0xFF5B5FEF),
    customRole: true,
    scenarios: [
      Scenario('role_pm', 'Product Manager'),
      Scenario('role_swe', 'Software Engineer'),
      Scenario('role_marketing', 'Marketing Executive'),
      Scenario('role_support', 'Customer Support Agent'),
      Scenario('role_fresher', 'First job as a fresher'),
    ],
  ),
  RoomInfo(
    room: CoachRoom.travel,
    icon: Icons.flight_takeoff_rounded,
    color: Color(0xFF0D9488),
    scenarios: [
      Scenario('travel_airport', 'Airport check-in'),
      Scenario('travel_hotel', 'Hotel check-in'),
      Scenario('travel_restaurant', 'Ordering at a restaurant'),
      Scenario('travel_directions', 'Asking for directions in a new city'),
      Scenario('travel_market', 'Shopping and bargaining at a market'),
      Scenario('travel_pharmacy', 'At a pharmacy, describing how you feel'),
    ],
  ),
  RoomInfo(
    room: CoachRoom.daily,
    icon: Icons.local_cafe_rounded,
    color: Color(0xFFF2711C),
    scenarios: [
      Scenario('daily_intro', 'Introducing yourself to new people'),
      Scenario('daily_smalltalk', 'Small talk with a neighbour'),
      Scenario('daily_phone', 'Booking an appointment by phone'),
      Scenario('daily_friend', 'Making a new friend at a party'),
      Scenario('daily_landlord', 'Telling your landlord about a problem'),
    ],
  ),
  RoomInfo(
    room: CoachRoom.pitch,
    icon: Icons.campaign_rounded,
    color: Color(0xFFE11D74),
    scenarios: [
      Scenario('pitch_intro', 'A 30-second self-introduction'),
      Scenario('pitch_product', 'Pitching a product or startup idea'),
      Scenario('pitch_talk', 'A short talk about something you love'),
    ],
  ),
  RoomInfo(
    room: CoachRoom.free,
    icon: Icons.forum_rounded,
    color: Color(0xFF1D7BE8),
    scenarios: [
      Scenario('free_day', 'Talking about my day'),
      Scenario('free_hobbies', 'My hobbies and interests'),
      Scenario('free_plans', 'Weekend and future plans'),
      Scenario('free_opinions', 'Sharing opinions on everyday topics'),
    ],
  ),
  RoomInfo(
    room: CoachRoom.picture,
    icon: Icons.photo_camera_rounded,
    color: Color(0xFF8B5CF6),
    needsPhoto: true,
  ),
];

RoomInfo roomInfo(CoachRoom room) => rooms.firstWhere((r) => r.room == room);

RoomInfo roomInfoById(String id) => rooms.firstWhere(
  (r) => r.id == id,
  orElse: () => rooms.first,
);

/// Everything needed to start (and later review) a practice session.
class SessionSetup {
  final CoachRoom room;

  /// English description of the scenario or role, sent to the coach.
  final String scenario;

  /// Localised label of the scenario, shown in the app.
  final String scenarioLabel;
  final String level;
  final String practiceLang;

  /// Photo for Picture Talk.
  final PhotoAttachment? photo;

  const SessionSetup({
    required this.room,
    required this.scenario,
    required this.scenarioLabel,
    required this.level,
    required this.practiceLang,
    this.photo,
  });
}

class PhotoAttachment {
  final String mimeType;
  final String base64Data;
  final Uint8List bytes;

  const PhotoAttachment({
    required this.mimeType,
    required this.base64Data,
    required this.bytes,
  });
}

/// The coach's feedback on one learner message.
class CoachFeedback {
  final String corrected;
  final String explanation;
  final String tip;
  final int score;

  const CoachFeedback({
    this.corrected = '',
    this.explanation = '',
    this.tip = '',
    this.score = 0,
  });

  factory CoachFeedback.fromJson(Map<String, dynamic>? j) => CoachFeedback(
    corrected: '${j?['corrected'] ?? ''}',
    explanation: '${j?['explanation'] ?? ''}',
    tip: '${j?['tip'] ?? ''}',
    score: ((j?['score'] as num?)?.toInt() ?? 0).clamp(0, 100),
  );

  /// Whether the learner's sentence needed a fix.
  bool get hasCorrection => corrected.trim().isNotEmpty;
}

class CoachMessage {
  final bool fromCoach;
  final String text;

  /// The coach's message in the learner's own language.
  final String translation;

  /// Feedback on a learner message (filled in once the coach replies).
  CoachFeedback? feedback;

  /// Failed to send: the learner can retry.
  bool failed;

  CoachMessage({
    required this.fromCoach,
    required this.text,
    this.translation = '',
    this.feedback,
    this.failed = false,
  });

  Map<String, String> toApi() => {
    'role': fromCoach ? 'coach' : 'user',
    'text': text,
  };
}

class CoachReply {
  final String reply;
  final String translation;
  final CoachFeedback feedback;
  final List<String> suggestions;

  const CoachReply({
    required this.reply,
    required this.translation,
    required this.feedback,
    required this.suggestions,
  });

  factory CoachReply.fromJson(Map<String, dynamic> j) => CoachReply(
    reply: '${j['reply'] ?? ''}',
    translation: '${j['reply_translation'] ?? ''}',
    feedback: CoachFeedback.fromJson(j['feedback'] as Map<String, dynamic>?),
    suggestions: ((j['suggestions'] as List?) ?? [])
        .map((e) => '$e')
        .where((e) => e.trim().isNotEmpty)
        .toList(),
  );
}

class VocabItem {
  final String word;
  final String meaning;

  const VocabItem(this.word, this.meaning);
}

class SessionSummary {
  final int overallScore;
  final String summary;
  final List<String> strengths;
  final List<String> improvements;
  final List<VocabItem> vocabulary;
  final String nextGoal;

  const SessionSummary({
    required this.overallScore,
    required this.summary,
    required this.strengths,
    required this.improvements,
    required this.vocabulary,
    required this.nextGoal,
  });

  factory SessionSummary.fromJson(Map<String, dynamic> j) => SessionSummary(
    overallScore: ((j['overall_score'] as num?)?.toInt() ?? 0).clamp(0, 100),
    summary: '${j['summary'] ?? ''}',
    strengths: ((j['strengths'] as List?) ?? []).map((e) => '$e').toList(),
    improvements: ((j['improvements'] as List?) ?? []).map((e) => '$e').toList(),
    vocabulary: ((j['vocabulary'] as List?) ?? [])
        .map(
          (e) => VocabItem('${(e as Map)['word'] ?? ''}', '${e['meaning'] ?? ''}'),
        )
        .where((v) => v.word.isNotEmpty)
        .toList(),
    nextGoal: '${j['next_goal'] ?? ''}',
  );
}

/// Why a coach request failed, so the UI can show a message in the right language.
enum CoachErrorKind { network, busy, timeout, tooLarge, server }

class CoachException implements Exception {
  final CoachErrorKind kind;

  const CoachException(this.kind);

  @override
  String toString() => 'CoachException(${kind.name})';
}
