/// Where the app finds its backend. Nothing here is a secret: the Gemini key lives
/// on the server, so visitors never paste a key.
class AppConfig {
  AppConfig._();

  /// The BlueSpeak coach edge function. Override at build time with
  /// `--dart-define=COACH_URL=https://.../functions/v1/bluespeak-coach`.
  static const String coachUrl = String.fromEnvironment(
    'COACH_URL',
    defaultValue:
        'https://pbobinyancnyylqhqevn.supabase.co/functions/v1/bluespeak-coach',
  );

  static const String supportEmail = 'bluespeak.assistant@gmail.com';

  /// Keep in sync with `version:` in pubspec.yaml.
  static const String version = '1.1.0';
}
