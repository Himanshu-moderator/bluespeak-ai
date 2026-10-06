import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../core/languages.dart';

/// Reads the coach's messages aloud. Fails quietly where a device has no voice.
class SpeechOutput extends ChangeNotifier {
  SpeechOutput() {
    _init();
  }

  final FlutterTts _tts = FlutterTts();
  bool _speaking = false;
  bool _ready = false;
  String? _currentText;

  bool get speaking => _speaking;
  String? get currentText => _currentText;

  Future<void> _init() async {
    try {
      await _tts.awaitSpeakCompletion(false);
      _tts.setStartHandler(() => _set(true));
      _tts.setCompletionHandler(() => _set(false));
      _tts.setCancelHandler(() => _set(false));
      _tts.setErrorHandler((_) => _set(false));
      await _tts.setSpeechRate(kIsWeb ? 0.95 : 0.46);
      await _tts.setPitch(1.08);
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  void _set(bool value) {
    _speaking = value;
    if (!value) _currentText = null;
    notifyListeners();
  }

  Future<void> speak(String text, String langCode) async {
    if (!_ready || text.trim().isEmpty) return;
    try {
      await _tts.stop();
      _currentText = text;
      final bcp47 = languageFor(langCode).bcp47;
      await _tts.setLanguage(bcp47);
      await _pickVoice(bcp47);
      await _tts.speak(text);
    } catch (_) {
      _set(false);
    }
  }

  final Map<String, Map<String, String>?> _voiceCache = {};

  /// Picks the most natural-sounding female voice the device has for [bcp47].
  /// Falls back to the system default when nothing suitable is installed.
  Future<void> _pickVoice(String bcp47) async {
    if (!_voiceCache.containsKey(bcp47)) {
      _voiceCache[bcp47] = await _bestVoice(bcp47);
    }
    final voice = _voiceCache[bcp47];
    if (voice != null) await _tts.setVoice(voice);
  }

  static const _naturalHints = ['natural', 'neural', 'online', 'enhanced', 'premium', 'wavenet', 'google'];
  static const _femaleHints = [
    'female', 'aria', 'jenny', 'samantha', 'zira', 'susan', 'karen', 'moira', 'tessa', 'serena',
    'allison', 'ava', 'zoe', 'heera', 'kalpana', 'lekha', 'swara', 'neerja', 'paulina', 'monica',
    'helena', 'elvira', 'dalia', 'amelie', 'audrey', 'denise', 'eloise', 'julie', 'hortense',
    'xiaoxiao', 'xiaoyi', 'huihui', 'tingting', 'meijia', 'mei-jia', 'yaoyao', 'sinji', '-tpf', '-sfg',
  ];
  static const _maleHints = [
    'male', 'david', 'mark', 'daniel', 'alex', 'fred', 'george', 'guy', 'ryan', 'rishi', 'hemant',
    'ravi', 'jorge', 'diego', 'pablo', 'thomas', 'yunxi', 'kangkang', 'yunyang', 'madhur', 'prabhat', '-iom', '-iol',
  ];

  Future<Map<String, String>?> _bestVoice(String bcp47) async {
    try {
      final raw = await _tts.getVoices;
      if (raw is! List) return null;
      final lang = bcp47.split('-').first.toLowerCase();
      Map<String, String>? best;
      var bestScore = -999;
      for (final item in raw) {
        if (item is! Map) continue;
        final name = '${item['name'] ?? ''}';
        final locale = '${item['locale'] ?? ''}'.replaceAll('_', '-');
        if (name.isEmpty || !locale.toLowerCase().startsWith(lang)) continue;
        final n = name.toLowerCase();
        var score = 0;
        if (locale.toLowerCase() == bcp47.toLowerCase()) score += 2;
        if (_naturalHints.any(n.contains)) score += 4;
        if (_femaleHints.any(n.contains)) score += 5;
        if (_maleHints.any(n.contains)) score -= 8;
        if (n.contains('network') || n.contains('enhanced')) score += 1;
        if (score > bestScore) {
          bestScore = score;
          best = {'name': name, 'locale': '${item['locale']}'};
        }
      }
      return best;
    } catch (_) {
      return null;
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
    _set(false);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}

/// Speech to text for the microphone button.
class VoiceInput extends ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _available = false;
  bool _initialised = false;
  bool _listening = false;

  bool get listening => _listening;
  bool get available => _available;

  Future<bool> _ensure() async {
    if (_initialised) return _available;
    _initialised = true;
    try {
      _available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') _setListening(false);
        },
        onError: (_) => _setListening(false),
      );
    } catch (_) {
      _available = false;
    }
    notifyListeners();
    return _available;
  }

  void _setListening(bool value) {
    if (_listening == value) return;
    _listening = value;
    notifyListeners();
  }

  /// Starts listening. [onText] gets the words so far; [onFinal] fires once with the
  /// finished sentence. Returns false when speech recognition is not available.
  Future<bool> start({
    required String langCode,
    required void Function(String text) onText,
    required void Function(String text) onFinal,
  }) async {
    if (!await _ensure()) return false;
    _setListening(true);
    try {
      await _speech.listen(
        listenOptions: stt.SpeechListenOptions(
          localeId: languageFor(langCode).speechLocaleId,
          partialResults: true,
          cancelOnError: true,
          listenMode: stt.ListenMode.dictation,
          pauseFor: const Duration(seconds: 3),
          listenFor: const Duration(seconds: 60),
        ),
        onResult: (result) {
          onText(result.recognizedWords);
          if (result.finalResult) {
            _setListening(false);
            onFinal(result.recognizedWords);
          }
        },
      );
      return true;
    } catch (_) {
      _setListening(false);
      return false;
    }
  }

  Future<void> stop() async {
    try {
      await _speech.stop();
    } catch (_) {}
    _setListening(false);
  }

  @override
  void dispose() {
    _speech.cancel();
    super.dispose();
  }
}
