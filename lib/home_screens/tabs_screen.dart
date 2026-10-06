import 'package:flutter/material.dart';

import '../l10n/l10n_helpers.dart';
import 'coach_home_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';

/// The signed-in shell: Practice, Progress and Profile.
class CustomTabBarScreen extends StatefulWidget {
  const CustomTabBarScreen({
    super.key,
    this.userName = '',
    this.userEmail = '',
  });

  final String userName;
  final String userEmail;

  @override
  State<CustomTabBarScreen> createState() => _CustomTabBarScreenState();
}

class _CustomTabBarScreenState extends State<CustomTabBarScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          CoachHomeScreen(userName: widget.userName),
          const ProgressScreen(),
          ProfileScreen(userName: widget.userName, userEmail: widget.userEmail),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.mic_none_rounded),
            selectedIcon: const Icon(Icons.mic_rounded),
            label: l.navPractice,
          ),
          NavigationDestination(
            icon: const Icon(Icons.insights_outlined),
            selectedIcon: const Icon(Icons.insights_rounded),
            label: l.navProgress,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: l.navProfile,
          ),
        ],
      ),
    );
  }
}
