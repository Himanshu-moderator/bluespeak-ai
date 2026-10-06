import 'package:flutter/material.dart';

import '../coach/coach_models.dart';
import '../coach/coach_service.dart';
import '../coach/voice_services.dart';
import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/languages.dart';
import '../l10n/l10n_helpers.dart';
import '../widgets/message_bubbles.dart';
import 'session_summary_screen.dart';

/// A live practice session: talk (or type) to the coach and get feedback on every message.
class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key, required this.setup, CoachService? service})
    : _service = service;

  final SessionSetup setup;
  final CoachService? _service;

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late final CoachService _service = widget._service ?? CoachService();
  final SpeechOutput _speech = SpeechOutput();
  final VoiceInput _voice = VoiceInput();
  final List<CoachMessage> _messages = [];
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  List<String> _suggestions = [];
  bool _loading = false;
  bool _opening = true;
  CoachErrorKind? _openError;

  AppSettings get _settings => AppSettings.instance;
  bool get _hasLearnerMessage => _messages.any((m) => !m.fromCoach);

  @override
  void initState() {
    super.initState();
    _open();
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    _speech.dispose();
    _voice.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _open() async {
    setState(() {
      _opening = true;
      _openError = null;
    });
    try {
      final reply = await _service.reply(
        setup: widget.setup,
        uiLang: _settings.uiLang,
        messages: const [],
      );
      if (!mounted) return;
      _addCoachMessage(reply);
    } on CoachException catch (e) {
      if (mounted) setState(() => _openError = e.kind);
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  void _addCoachMessage(CoachReply reply) {
    setState(() {
      _messages.add(
        CoachMessage(
          fromCoach: true,
          text: reply.reply,
          translation: reply.translation,
        ),
      );
      _suggestions = reply.suggestions;
    });
    _scrollToEnd();
    if (_settings.autoSpeak) {
      _speech.speak(reply.reply, widget.setup.practiceLang);
    }
  }

  Future<void> _send(String raw) async {
    final text = raw.trim();
    if (text.isEmpty || _loading || _opening) return;
    _speech.stop();
    await _voice.stop();
    setState(() {
      _messages.add(CoachMessage(fromCoach: false, text: text));
      _suggestions = [];
      _input.clear();
    });
    _scrollToEnd();
    await _ask();
  }

  Future<void> _ask() async {
    setState(() => _loading = true);
    _scrollToEnd();
    try {
      final reply = await _service.reply(
        setup: widget.setup,
        uiLang: _settings.uiLang,
        messages: _messages,
      );
      if (!mounted) return;
      final lastUser = _messages.lastWhere((m) => !m.fromCoach);
      lastUser.feedback = reply.feedback;
      _addCoachMessage(reply);
    } on CoachException catch (e) {
      if (!mounted) return;
      final lastUser = _messages.lastWhere((m) => !m.fromCoach);
      setState(() => lastUser.failed = true);
      _showSnack(coachErrorText(context.l10n, e.kind));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _retry(CoachMessage message) {
    if (_loading) return;
    setState(() => message.failed = false);
    _ask();
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _toggleMic() async {
    if (_voice.listening) {
      await _voice.stop();
      return;
    }
    _speech.stop();
    final ok = await _voice.start(
      langCode: widget.setup.practiceLang,
      onText: (text) {
        _input.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      },
      onFinal: (text) {
        if (text.trim().isNotEmpty) _send(text);
      },
    );
    if (!ok && mounted) _showSnack(context.l10n.micUnavailable);
  }

  Future<void> _finish() async {
    final l = context.l10n;
    if (!_hasLearnerMessage) {
      _showSnack(l.finishNeedMessage);
      return;
    }
    final yes = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.finishTitle),
        content: Text(l.finishBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(110, 46)),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.practiceFinish),
          ),
        ],
      ),
    );
    if (yes != true || !mounted) return;
    await _speech.stop();
    await _voice.stop();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SessionSummaryScreen(
          setup: widget.setup,
          messages: List.of(_messages),
        ),
      ),
    );
  }

  Future<bool> _confirmLeave() async {
    final l = context.l10n;
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.leaveTitle),
        content: Text(l.leaveBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.stay)),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(110, 46)),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.leave),
          ),
        ],
      ),
    );
    return leave == true;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final setup = widget.setup;
    final room = roomInfo(setup.room);

    return PopScope(
      canPop: !_hasLearnerMessage,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final leave = await _confirmLeave();
        if (leave && context.mounted) Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: room.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(room.icon, color: room.color, size: 21),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomName(l, setup.room),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      [
                        if (setup.scenarioLabel.isNotEmpty) setup.scenarioLabel,
                        languageFor(setup.practiceLang).nativeName,
                        levelLabel(l, setup.level),
                      ].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ListenableBuilder(
              listenable: _settings,
              builder: (context, _) => IconButton(
                tooltip: _settings.autoSpeak ? l.voiceOn : l.voiceOff,
                icon: Icon(
                  _settings.autoSpeak ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                  color: _settings.autoSpeak ? scheme.primary : scheme.onSurfaceVariant,
                ),
                onPressed: () {
                  final next = !_settings.autoSpeak;
                  _settings.setAutoSpeak(next);
                  if (!next) _speech.stop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FilledButton.tonalIcon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                ),
                onPressed: _finish,
                icon: const Icon(Icons.flag_rounded, size: 18),
                label: Text(l.practiceFinish),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: _buildConversation(context)),
            _buildSuggestions(context),
            _buildInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildConversation(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    if (_opening) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 34, height: 34, child: CircularProgressIndicator(strokeWidth: 3)),
            const SizedBox(height: 16),
            Text(l.practiceSettingUp, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      );
    }
    if (_openError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_rounded, size: 48, color: scheme.onSurfaceVariant),
              const SizedBox(height: 14),
              Text(
                coachErrorText(l, _openError!),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 18),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(160, 48)),
                onPressed: _open,
                child: Text(l.retry),
              ),
            ],
          ),
        ),
      );
    }

    final photo = widget.setup.photo;
    return ListView(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        if (photo != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.memory(photo.bytes, height: 190, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
        for (final m in _messages) ...[
          if (m.fromCoach)
            ListenableBuilder(
              listenable: _speech,
              builder: (context, _) => CoachBubble(
                message: m,
                speaking: _speech.speaking && _speech.currentText == m.text,
                onListen: () => (_speech.speaking && _speech.currentText == m.text)
                    ? _speech.stop()
                    : _speech.speak(m.text, widget.setup.practiceLang),
              ),
            )
          else ...[
            UserBubble(message: m, onRetry: () => _retry(m)),
            if (m.feedback != null) ...[
              const SizedBox(height: 8),
              FeedbackCard(
                feedback: m.feedback!,
                onListen: (text) => _speech.speak(text, widget.setup.practiceLang),
              ),
            ],
          ],
          const SizedBox(height: 14),
        ],
        if (_loading) const TypingBubble(),
      ],
    );
  }

  Widget _buildSuggestions(BuildContext context) {
    if (_suggestions.isEmpty || _loading || _opening) return const SizedBox.shrink();
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.youCouldSay,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) => ActionChip(
                label: Text(_suggestions[i]),
                backgroundColor: scheme.primary.withValues(alpha: 0.10),
                side: BorderSide(color: scheme.primary.withValues(alpha: 0.3)),
                labelStyle: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700),
                onPressed: () {
                  _input.value = TextEditingValue(
                    text: _suggestions[i],
                    selection: TextSelection.collapsed(offset: _suggestions[i].length),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final disabled = _opening || _openError != null;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: BoxDecoration(
          color: scheme.panel,
          border: Border(top: BorderSide(color: scheme.hairline)),
        ),
        child: ListenableBuilder(
          listenable: Listenable.merge([_voice, _input]),
          builder: (context, _) {
            final listening = _voice.listening;
            final hasText = _input.text.trim().isNotEmpty;
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _input,
                    enabled: !disabled,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _send,
                    decoration: InputDecoration(
                      hintText: listening ? l.practiceListening : l.practiceHint,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: listening ? scheme.error : scheme.hairline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: listening ? scheme.error : scheme.hairline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide(color: scheme.primary, width: 1.6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (hasText && !listening)
                  _RoundButton(
                    icon: Icons.arrow_upward_rounded,
                    color: scheme.primary,
                    onTap: disabled || _loading ? null : () => _send(_input.text),
                  )
                else
                  _RoundButton(
                    icon: listening ? Icons.stop_rounded : Icons.mic_rounded,
                    color: listening ? scheme.error : scheme.primary,
                    pulsing: listening,
                    onTap: disabled || _loading ? null : _toggleMic,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RoundButton extends StatefulWidget {
  const _RoundButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.pulsing = false,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool pulsing;

  @override
  State<_RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<_RoundButton> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void didUpdateWidget(covariant _RoundButton old) {
    super.didUpdateWidget(old);
    if (widget.pulsing && !_c.isAnimating) _c.repeat();
    if (!widget.pulsing && _c.isAnimating) _c.reset();
  }

  @override
  void initState() {
    super.initState();
    if (widget.pulsing) _c.repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, child) => Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled ? widget.color : widget.color.withValues(alpha: 0.35),
            boxShadow: widget.pulsing
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.45 * (1 - _c.value)),
                      blurRadius: 4 + 16 * _c.value,
                      spreadRadius: 10 * _c.value,
                    ),
                  ]
                : null,
          ),
          child: child,
        ),
        child: Icon(widget.icon, color: Colors.white, size: 26),
      ),
    );
  }
}
