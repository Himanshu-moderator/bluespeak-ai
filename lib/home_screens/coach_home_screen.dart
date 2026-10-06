import 'package:flutter/material.dart';

import '../coach/coach_models.dart';
import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/progress_store.dart';
import '../l10n/l10n_helpers.dart';
import '../widgets/app_widgets.dart';
import 'practice_screen.dart';
import 'session_setup_sheet.dart';

/// The Practice tab: today's challenge, this week, and the practice rooms.
class CoachHomeScreen extends StatelessWidget {
  const CoachHomeScreen({super.key, this.userName = ''});

  final String userName;

  /// One suggested situation per day, the same for everyone on that day.
  static (RoomInfo, Scenario) todaysChallenge() {
    final pool = <(RoomInfo, Scenario)>[
      for (final r in rooms)
        for (final s in r.scenarios)
          if (!r.customRole) (r, s),
    ];
    final day = DateTime.now().difference(DateTime(2024)).inDays;
    return pool[day % pool.length];
  }

  Future<void> _open(
    BuildContext context,
    RoomInfo room, {
    String? presetScenarioId,
  }) async {
    final setup = await showSessionSetup(
      context,
      room,
      presetScenarioId: presetScenarioId,
    );
    if (setup == null || !context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PracticeScreen(setup: setup)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final name = userName.trim().split(' ').first;

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: Listenable.merge([ProgressStore.instance, AppSettings.instance]),
        builder: (context, _) {
          final progress = ProgressStore.instance;
          final (challengeRoom, challenge) = todaysChallenge();
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.isEmpty ? l.homeGreetingGuest : l.homeGreeting(name),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l.homeSubtitle,
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  StreakChip(
                    text: l.streakDays(progress.currentStreak),
                    active: progress.currentStreak > 0,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Today's challenge
              GestureDetector(
                onTap: () => _open(context, challengeRoom, presetScenarioId: challenge.id),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: scheme.brandGradient,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: scheme.primary.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                l.todayChallenge,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              scenarioLabel(l, challenge.id),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              roomName(l, challengeRoom.room),
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.mic_rounded, size: 18, color: scheme.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    l.startNow,
                                    style: TextStyle(
                                      color: scheme.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        challengeRoom.icon,
                        size: 78,
                        color: Colors.white.withValues(alpha: 0.28),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // This week
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.thisWeek,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _WeekRow(days: progress.lastWeek),
                      const SizedBox(height: 14),
                      Text(
                        progress.practicedToday ? l.practisedToday : l.keepStreak,
                        style: TextStyle(color: scheme.onSurfaceVariant, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),

              SectionHeader(l.practiceRooms),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.95,
                children: [
                  for (final r in rooms)
                    _RoomCard(room: r, onTap: () => _open(context, r)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  const _WeekRow({required this.days});

  /// Last 7 days, oldest first.
  final List<bool> days;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final narrow = MaterialLocalizations.of(context).narrowWeekdays;
    final today = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < 7; i++)
          Builder(
            builder: (context) {
              final date = DateTime(today.year, today.month, today.day - (6 - i));
              final practised = days[i];
              final isToday = i == 6;
              return Column(
                children: [
                  Text(
                    narrow[date.weekday % 7],
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isToday ? scheme.primary : scheme.onSurfaceVariant,
                      fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: practised ? scheme.primary : Colors.transparent,
                      border: Border.all(
                        color: practised
                            ? scheme.primary
                            : (isToday ? scheme.primary : scheme.hairline),
                        width: isToday && !practised ? 2 : 1.4,
                      ),
                    ),
                    child: practised
                        ? Icon(Icons.check_rounded, size: 19, color: scheme.onPrimary)
                        : null,
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room, required this.onTap});

  final RoomInfo room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.panel,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: scheme.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: room.color.withValues(alpha: scheme.isDark ? 0.24 : 0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(room.icon, color: room.color, size: 25),
              ),
              const Spacer(),
              Text(
                roomName(l, room.room),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                roomDescription(l, room.room),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
