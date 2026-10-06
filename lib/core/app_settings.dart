import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'languages.dart';

/// User preferences, saved on the device. Listen to it to rebuild on change.
class AppSettings extends ChangeNotifier {
  AppSettings._();

  static final AppSettings instance = AppSettings._();

  /// For tests: a fresh instance that does not share state.
  AppSettings.forTest();

  static const _kTheme = 'theme_mode';
  static const _kAccent = 'accent';
  static const _kUiLang = 'ui_lang';
  static const _kPracticeLang = 'practice_lang';
  static const _kLevel = 'level';
  static const _kAutoSpeak = 'auto_speak';
  static const _kGuest = 'guest';
  static const _kGuestName = 'guest_name';
  static const _kSeenOnboarding = 'seen_onboarding';

  SharedPreferences? _prefs;

  ThemeMode _themeMode = ThemeMode.system;
  String _accent = 'indigo';
  String _uiLang = 'en';
  String _practiceLang = 'en';
  String _level = 'intermediate';
  bool _autoSpeak = true;
  bool _guest = false;
  String _guestName = '';
  bool _seenOnboarding = false;

  ThemeMode get themeMode => _themeMode;
  String get accentId => _accent;
  String get uiLang => _uiLang;
  String get practiceLang => _practiceLang;
  String get level => _level;
  bool get autoSpeak => _autoSpeak;
  bool get isGuest => _guest;
  String get guestName => _guestName;
  bool get seenOnboarding => _seenOnboarding;

  Locale get locale => Locale(_uiLang);

  Future<void> load() async {
    final p = _prefs = await SharedPreferences.getInstance();
    _themeMode = switch (p.getString(_kTheme)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    _accent = accentIdOr(p.getString(_kAccent));
    _uiLang = _validLang(p.getString(_kUiLang));
    _practiceLang = _validLang(p.getString(_kPracticeLang));
    final level = p.getString(_kLevel);
    _level = const ['beginner', 'intermediate', 'advanced'].contains(level)
        ? level!
        : 'intermediate';
    _autoSpeak = p.getBool(_kAutoSpeak) ?? true;
    _guest = p.getBool(_kGuest) ?? false;
    _guestName = p.getString(_kGuestName) ?? '';
    _seenOnboarding = p.getBool(_kSeenOnboarding) ?? false;
    notifyListeners();
  }

  static String accentIdOr(String? id) => id == null || id.isEmpty ? 'indigo' : id;

  static String _validLang(String? code) =>
      supportedLanguages.any((l) => l.code == code) ? code! : 'en';

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _prefs?.setString(_kTheme, mode.name);
  }

  Future<void> setAccent(String id) async {
    _accent = id;
    notifyListeners();
    await _prefs?.setString(_kAccent, id);
  }

  Future<void> setUiLang(String code) async {
    _uiLang = _validLang(code);
    notifyListeners();
    await _prefs?.setString(_kUiLang, _uiLang);
  }

  Future<void> setPracticeLang(String code) async {
    _practiceLang = _validLang(code);
    notifyListeners();
    await _prefs?.setString(_kPracticeLang, _practiceLang);
  }

  Future<void> setLevel(String level) async {
    _level = level;
    notifyListeners();
    await _prefs?.setString(_kLevel, level);
  }

  Future<void> setAutoSpeak(bool value) async {
    _autoSpeak = value;
    notifyListeners();
    await _prefs?.setBool(_kAutoSpeak, value);
  }

  Future<void> setGuest(bool value, {String name = ''}) async {
    _guest = value;
    _guestName = value ? name : '';
    notifyListeners();
    await _prefs?.setBool(_kGuest, value);
    await _prefs?.setString(_kGuestName, _guestName);
  }

  Future<void> markOnboardingSeen() async {
    _seenOnboarding = true;
    await _prefs?.setBool(_kSeenOnboarding, true);
  }
}
