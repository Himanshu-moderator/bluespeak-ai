import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../home_screens/tabs_screen.dart';
import '../services/auth_service.dart';

/// Replaces the current screen with the main app, for the signed-in user or the guest.
void goToHome(BuildContext context) {
  final user = AuthService.currentUser;
  final settings = AppSettings.instance;
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => CustomTabBarScreen(
        userName: user?.displayName ?? settings.guestName,
        userEmail: user?.email ?? '',
      ),
    ),
    (route) => false,
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
