import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// A language the app can be shown in and that learners can practise.
class AppLanguage {
  final String code;
  final String nativeName;
  final String englishName;

  /// BCP-47 tag used for speech recognition and text to speech.
  final String bcp47;

  const AppLanguage({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.bcp47,
  });

  Locale get locale => Locale(code);

  /// Browsers want `en-US`; the Android/iOS speech engines want `en_US`.
  String get speechLocaleId => kIsWeb ? bcp47 : bcp47.replaceAll('-', '_');
}

/// English first: it is the default for both the app and for practice.
const List<AppLanguage> supportedLanguages = [
  AppLanguage(
    code: 'en',
    nativeName: 'English',
    englishName: 'English',
    bcp47: 'en-US',
  ),
  AppLanguage(
    code: 'hi',
    nativeName: 'हिन्दी',
    englishName: 'Hindi',
    bcp47: 'hi-IN',
  ),
  AppLanguage(
    code: 'es',
    nativeName: 'Español',
    englishName: 'Spanish',
    bcp47: 'es-ES',
  ),
  AppLanguage(
    code: 'fr',
    nativeName: 'Français',
    englishName: 'French',
    bcp47: 'fr-FR',
  ),
  AppLanguage(
    code: 'zh',
    nativeName: '中文',
    englishName: 'Chinese (Mandarin)',
    bcp47: 'zh-CN',
  ),
];

AppLanguage languageFor(String code) => supportedLanguages.firstWhere(
  (l) => l.code == code,
  orElse: () => supportedLanguages.first,
);

List<Locale> get supportedLocales =>
    supportedLanguages.map((l) => l.locale).toList();
