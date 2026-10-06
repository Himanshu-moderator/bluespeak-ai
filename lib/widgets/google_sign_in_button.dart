import 'package:flutter/material.dart';

import '../auth/auth_navigation.dart';
import '../l10n/l10n_helpers.dart';
import '../services/auth_service.dart';

/// "Continue with Google" button shared by the login and signup screens.
class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _busy = false;

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      final signedIn = await AuthService.signInWithGoogle();
      if (signedIn && mounted) goToHome(context);
    } on AuthException catch (e) {
      if (mounted) showMessage(context, authErrorText(context.l10n, e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: _busy ? null : _signIn,
      icon: _busy
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.g_mobiledata_rounded, color: Color(0xFFEA4335), size: 32),
      label: Text(context.l10n.continueWithGoogle),
    );
  }
}
