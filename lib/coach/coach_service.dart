import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/app_config.dart';
import 'coach_models.dart';

/// Talks to the BlueSpeak coach backend (a Supabase edge function that holds the
/// Gemini key). The app itself never sees a key.
class CoachService {
  CoachService({http.Client? client, String? url})
    : _client = client ?? http.Client(),
      _url = url ?? AppConfig.coachUrl;

  final http.Client _client;
  final String _url;

  static const _timeout = Duration(seconds: 70);

  Future<Map<String, dynamic>> _post(Map<String, dynamic> body) async {
    final http.Response response;
    try {
      response = await _client
          .post(
            Uri.parse(_url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(_timeout);
    } on Exception catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw const CoachException(CoachErrorKind.timeout);
      }
      throw const CoachException(CoachErrorKind.network);
    }

    if (response.statusCode == 200) {
      try {
        return jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      } catch (_) {
        throw const CoachException(CoachErrorKind.server);
      }
    }
    switch (response.statusCode) {
      case 413:
        throw const CoachException(CoachErrorKind.tooLarge);
      case 429:
        throw const CoachException(CoachErrorKind.busy);
      case 504:
        throw const CoachException(CoachErrorKind.timeout);
      default:
        throw const CoachException(CoachErrorKind.server);
    }
  }

  Map<String, dynamic> _base(
    String action,
    SessionSetup setup,
    String uiLang,
    List<CoachMessage> messages,
  ) => {
    'action': action,
    'mode': setup.room.name,
    'scenario': setup.scenario,
    'level': setup.level,
    'practiceLang': setup.practiceLang,
    'uiLang': uiLang,
    'messages': messages.map((m) => m.toApi()).toList(),
    if (setup.photo != null) ...{
      'image': setup.photo!.base64Data,
      'mimeType': setup.photo!.mimeType,
    },
  };

  /// The coach's next message. With no messages yet, this opens the session.
  Future<CoachReply> reply({
    required SessionSetup setup,
    required String uiLang,
    required List<CoachMessage> messages,
  }) async => CoachReply.fromJson(
    await _post(_base('reply', setup, uiLang, messages)),
  );

  Future<SessionSummary> summary({
    required SessionSetup setup,
    required String uiLang,
    required List<CoachMessage> messages,
  }) async => SessionSummary.fromJson(
    await _post(_base('summary', setup, uiLang, messages)),
  );
}
