import 'package:flutter/material.dart';

import '../coach/coach_models.dart';
import '../core/app_theme.dart';
import '../core/progress_store.dart';
import '../l10n/l10n_helpers.dart';
import '../widgets/app_widgets.dart';

/// The Progress tab: streaks, scores and recent sessions.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final l = context.l10n;
    final yes = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.clearHistory),
        content: Text(l.clearHistoryBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size(110, 46),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.delete),
          ),
        ],
      ),
    );
    if (yes == true) ProgressStore.instance.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: ProgressStore.instance,
        builder: (context, _) {
          final p = ProgressStore.instance;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            children: [
              Text(
                l.progressTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 18),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.55,
                children: [
                  _StatTile(
                    icon: Icons.local_fire_department_rounded,
                    color: const Color(0xFFF97316),
                    value: '${p.currentStreak}',
                    label: l.statStreak,
                  ),
                  _StatTile(
                    icon: Icons.emoji_events_rounded,
                    color: const Color(0xFFEAB308),
                    value: '${p.bestStreak}',
                    label: l.statBestStreak,
                  ),
                  _StatTile(
                    icon: Icons.mic_rounded,
                    color: scheme.primary,
                    value: '${p.totalSessions}',
                    label: l.statSessions,
                  ),
                  _StatTile(
                    icon: Icons.forum_rounded,
                    color: const Color(0xFF0D9488),
                    value: '${p.totalMessages}',
                    label: l.statMessages,
                  ),
                  _StatTile(
                    icon: Icons.speed_rounded,
                    color: scheme.success,
                    value: p.totalSessions == 0 ? '–' : '${p.averageScore}',
                    label: l.statAverage,
                  ),
                  _StatTile(
                    icon: Icons.star_rounded,
                    color: const Color(0xFFE11D74),
                    value: p.totalSessions == 0 ? '–' : '${p.bestScore}',
                    label: l.statBest,
                  ),
                ],
              ),
              SectionHeader(
                l.recentSessions,
                trailing: p.sessions.isEmpty
                    ? null
                    : TextButton(
                        onPressed: () => _confirmClear(context),
                        child: Text(l.clearHistory),
                      ),
              ),
              if (p.sessions.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      children: [
                        Icon(Icons.insights_rounded, size: 44, color: scheme.onSurfaceVariant),
                        const SizedBox(height: 12),
                        Text(
                          l.noSessions,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: scheme.onSurfaceVariant, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                )
              else
                for (final s in p.sessions.take(20)) _SessionTile(record: s),
            ],
          );
        },
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.hairline),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 23),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                Text(
                  label,
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
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.record});

  final SessionRecord record;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final room = roomInfoById(record.roomId);
    final date = MaterialLocalizations.of(context).formatMediumDate(record.date);
    final color = ScoreRing.colorFor(scheme, record.score);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scheme.panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.hairline),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: room.color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(room.icon, color: room.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName(l, room.room),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$date · ${levelLabel(l, record.level)} · ${l.messagesCount(record.messages)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${record.score}',
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
