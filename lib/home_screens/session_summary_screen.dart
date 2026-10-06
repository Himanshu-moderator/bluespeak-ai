import 'package:flutter/material.dart';

import '../coach/coach_models.dart';
import '../coach/coach_service.dart';
import '../coach/voice_services.dart';
import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/progress_store.dart';
import '../l10n/l10n_helpers.dart';
import '../widgets/app_widgets.dart';
import 'practice_screen.dart';

/// The end-of-session review: score, what went well, what to work on, new words.
class SessionSummaryScreen extends StatefulWidget {
  const SessionSummaryScreen({
    super.key,
    required this.setup,
    required this.messages,
    CoachService? service,
  }) : _service = service;

  final SessionSetup setup;
  final List<CoachMessage> messages;
  final CoachService? _service;

  @override
  State<SessionSummaryScreen> createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  late final CoachService _service = widget._service ?? CoachService();
  final SpeechOutput _speech = SpeechOutput();

  SessionSummary? _summary;
  CoachErrorKind? _error;
  bool _loading = true;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _speech.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final summary = await _service.summary(
        setup: widget.setup,
        uiLang: AppSettings.instance.uiLang,
        messages: widget.messages,
      );
      if (!mounted) return;
      setState(() => _summary = summary);
      _save(summary.overallScore, summary.summary);
    } on CoachException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.kind);
      _save(_averageFeedbackScore(), '');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  int _averageFeedbackScore() {
    final scores = widget.messages
        .where((m) => !m.fromCoach && m.feedback != null)
        .map((m) => m.feedback!.score)
        .toList();
    if (scores.isEmpty) return 0;
    return (scores.reduce((a, b) => a + b) / scores.length).round();
  }

  /// A session counts for the streak even if the review itself could not load.
  void _save(int score, String summary) {
    if (_saved) return;
    _saved = true;
    ProgressStore.instance.add(
      SessionRecord(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        date: DateTime.now(),
        roomId: widget.setup.room.name,
        scenario: widget.setup.scenario,
        practiceLang: widget.setup.practiceLang,
        level: widget.setup.level,
        score: score,
        messages: widget.messages.where((m) => !m.fromCoach).length,
        summary: summary,
      ),
    );
  }

  void _backToHome() => Navigator.of(context).popUntil((route) => route.isFirst);

  void _again() => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => PracticeScreen(setup: widget.setup)),
  );

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(l.summaryTitle),
          actions: [
            IconButton(icon: const Icon(Icons.close_rounded), onPressed: _backToHome),
          ],
        ),
        body: _loading
            ? _buildLoading(context)
            : (_summary == null ? _buildError(context) : _buildSummary(context, _summary!)),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final l = context.l10n;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 38, height: 38, child: CircularProgressIndicator(strokeWidth: 3)),
          const SizedBox(height: 18),
          Text(
            l.summaryLoading,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 48, color: scheme.onSurfaceVariant),
            const SizedBox(height: 14),
            Text(l.summaryFailed, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              _error == null ? '' : coachErrorText(l, _error!),
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: _load, child: Text(l.retry)),
            const SizedBox(height: 10),
            OutlinedButton(onPressed: _backToHome, child: Text(l.summaryBack)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context, SessionSummary s) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    Widget bullet(IconData icon, Color color, String text) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(height: 1.4))),
        ],
      ),
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                ScoreRing(score: s.overallScore, size: 150, stroke: 13, label: l.summaryYourScore),
                const SizedBox(height: 18),
                Text(
                  s.summary,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ),
        if (s.strengths.isNotEmpty) ...[
          SectionHeader(l.summaryStrengths),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Column(
                children: [
                  for (final t in s.strengths)
                    bullet(Icons.check_circle_rounded, scheme.success, t),
                ],
              ),
            ),
          ),
        ],
        if (s.improvements.isNotEmpty) ...[
          SectionHeader(l.summaryImprove),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Column(
                children: [
                  for (final t in s.improvements)
                    bullet(Icons.trending_up_rounded, scheme.warning, t),
                ],
              ),
            ),
          ),
        ],
        if (s.vocabulary.isNotEmpty) ...[
          SectionHeader(l.summaryVocab),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final v in s.vocabulary)
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _speech.speak(v.word, widget.setup.practiceLang),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
                    decoration: BoxDecoration(
                      color: scheme.panel,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: scheme.hairline),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                v.word,
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                              ),
                              Text(
                                v.meaning,
                                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.volume_up_rounded, size: 18, color: scheme.primary),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
        if (s.nextGoal.isNotEmpty) ...[
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: scheme.brandGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.flag_rounded, color: Colors.white, size: 26),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.summaryNextGoal,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.nextGoal,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 26),
        FilledButton(onPressed: _again, child: Text(l.summaryAgain)),
        const SizedBox(height: 10),
        OutlinedButton(onPressed: _backToHome, child: Text(l.summaryBack)),
      ],
    );
  }
}
