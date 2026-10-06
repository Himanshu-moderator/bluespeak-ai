import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../coach/coach_models.dart';
import '../core/app_theme.dart';
import '../l10n/l10n_helpers.dart';
import 'app_widgets.dart';

/// A message from the coach, with "Listen" and (when available) "Translate".
class CoachBubble extends StatefulWidget {
  const CoachBubble({
    super.key,
    required this.message,
    required this.speaking,
    required this.onListen,
  });

  final CoachMessage message;
  final bool speaking;
  final VoidCallback onListen;

  @override
  State<CoachBubble> createState() => _CoachBubbleState();
}

class _CoachBubbleState extends State<CoachBubble> {
  bool _showTranslation = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final m = widget.message;
    final hasTranslation = m.translation.trim().isNotEmpty;

    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            margin: const EdgeInsets.only(right: 10, top: 2),
            decoration: BoxDecoration(
              gradient: scheme.brandGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.record_voice_over_rounded, color: Colors.white, size: 18),
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 13, 16, 8),
                decoration: BoxDecoration(
                  color: scheme.panel,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                  border: Border.all(color: scheme.hairline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      m.text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
                    ),
                    if (_showTranslation && hasTranslation) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: scheme.hairline)),
                        ),
                        child: Text(
                          m.translation,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 2,
                      children: [
                        _MiniAction(
                          icon: widget.speaking
                              ? Icons.stop_circle_rounded
                              : Icons.volume_up_rounded,
                          label: l.coachListen,
                          onTap: widget.onListen,
                          active: widget.speaking,
                        ),
                        if (hasTranslation)
                          _MiniAction(
                            icon: Icons.translate_rounded,
                            label: _showTranslation ? l.coachHideTranslation : l.coachTranslate,
                            onTap: () => setState(() => _showTranslation = !_showTranslation),
                            active: _showTranslation,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniAction extends StatelessWidget {
  const _MiniAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active ? scheme.primary : scheme.onSurfaceVariant;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 17, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The learner's own message.
class UserBubble extends StatelessWidget {
  const UserBubble({super.key, required this.message, required this.onRetry});

  final CoachMessage message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: GestureDetector(
              onTap: message.failed ? onRetry : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: message.failed ? null : scheme.brandGradient,
                  color: message.failed ? scheme.errorContainer : null,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: SelectableText(
                  message.text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: message.failed ? scheme.onErrorContainer : Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
          if (message.failed)
            Padding(
              padding: const EdgeInsets.only(top: 6, right: 4),
              child: InkWell(
                onTap: onRetry,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh_rounded, size: 16, color: scheme.error),
                    const SizedBox(width: 4),
                    Text(
                      context.l10n.messageFailed,
                      style: TextStyle(color: scheme.error, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The coach's correction, explanation, tip and score for one learner message.
class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    super.key,
    required this.feedback,
    required this.onListen,
  });

  final CoachFeedback feedback;

  /// Reads the corrected sentence aloud.
  final void Function(String text) onListen;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final good = !feedback.hasCorrection;
    final accent = good ? scheme.success : scheme.warning;

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: scheme.isDark ? 0.12 : 0.09),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    good ? Icons.check_circle_rounded : Icons.edit_note_rounded,
                    size: 20,
                    color: accent,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      good ? l.feedbackGreat : l.feedbackSayIt,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _ScorePill(score: feedback.score),
                ],
              ),
              if (!good) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
                  decoration: BoxDecoration(
                    color: scheme.panel,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SelectableText(
                          feedback.corrected,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: l.coachListen,
                        icon: Icon(Icons.volume_up_rounded, size: 20, color: scheme.primary),
                        onPressed: () => onListen(feedback.corrected),
                      ),
                    ],
                  ),
                ),
              ],
              if (feedback.explanation.trim().isNotEmpty) ...[
                const SizedBox(height: 10),
                _Line(label: l.feedbackWhy, text: feedback.explanation),
              ],
              if (feedback.tip.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                _Line(
                  label: l.feedbackTip,
                  text: feedback.tip,
                  icon: Icons.lightbulb_rounded,
                  iconColor: scheme.warning,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.text, this.icon, this.iconColor});

  final String label;
  final String text;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 17, color: iconColor),
          const SizedBox(width: 6),
        ],
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(fontWeight: FontWeight.w800, color: scheme.onSurface),
                ),
                TextSpan(text: text, style: TextStyle(color: scheme.onSurfaceVariant)),
              ],
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _ScorePill extends StatelessWidget {
  const _ScorePill({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = ScoreRing.colorFor(scheme, score);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$score',
        style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 14),
      ),
    );
  }
}

/// Three bouncing dots while the coach is thinking.
class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 44),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: scheme.panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.hairline),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              final t = (_c.value - i * 0.18) % 1.0;
              final lift = math.max(0.0, math.sin(t * math.pi * 1.6)) * 6;
              return Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.only(right: i == 2 ? 0 : 5, bottom: lift),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.4 + 0.5 * (lift / 6)),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
