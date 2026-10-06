import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../auth/onboarding_screens.dart';
import '../auth/signup_screen.dart';
import '../core/app_config.dart';
import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../l10n/l10n_helpers.dart';
import '../services/auth_service.dart';
import '../settings/about_bluespeak.dart';
import '../settings/feedback_screen.dart';
import '../settings/preferences_screen.dart';
import '../settings/whats_new_screen.dart';
import '../widgets/app_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.userName = '', this.userEmail = ''});

  final String userName;
  final String userEmail;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userName = widget.userName;
  Uint8List? _photo;

  bool get _isGuest => AuthService.currentUser == null;

  Future<void> _logout() async {
    final l = context.l10n;
    final yes = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.logoutConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.no)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l.yes)),
        ],
      ),
    );
    if (yes != true || !mounted) return;
    final navigator = Navigator.of(context);
    await AuthService.signOut();
    await AppSettings.instance.setGuest(false);
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      (route) => false,
    );
  }

  void _showSupport() {
    final l = context.l10n;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.supportHelp),
        content: SelectableText(l.supportContact(AppConfig.supportEmail)),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(l.ok))],
      ),
    );
  }

  Future<void> _editProfile() async {
    final result = await showModalBottomSheet<_ProfileEdit>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EditProfileSheet(
        name: _userName,
        email: widget.userEmail,
        photo: _photo,
        canResetPassword: !_isGuest,
      ),
    );
    if (result == null || !mounted) return;
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      if (result.name.isNotEmpty && result.name != _userName) {
        if (_isGuest) {
          await AppSettings.instance.setGuest(true, name: result.name);
        } else {
          await AuthService.updateDisplayName(result.name);
        }
      }
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.profileUpdateFailed)));
      return;
    }
    setState(() {
      if (result.name.isNotEmpty) _userName = result.name;
      if (result.photo != null) _photo = result.photo;
    });
    messenger.showSnackBar(SnackBar(content: Text(l.profileUpdated)));
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final displayName = _userName.trim().isEmpty ? l.profileGuest : _userName;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        children: [
          Center(
            child: Column(
              children: [
                UserAvatar(name: displayName, bytes: _photo, radius: 46),
                const SizedBox(height: 14),
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                if (_isGuest)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      l.profileGuest,
                      style: TextStyle(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  )
                else
                  Text(widget.userEmail, style: TextStyle(color: scheme.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          if (_isGuest && AuthService.firebaseReady) ...[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: scheme.brandGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.profileGuestCta,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 14),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: scheme.primary,
                      minimumSize: const Size.fromHeight(46),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    ),
                    child: Text(l.createAccount),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          SettingsGroup(
            children: [
              SettingsRow(
                icon: Icons.edit_rounded,
                label: l.editProfile,
                onTap: _editProfile,
              ),
              SettingsRow(
                icon: Icons.tune_rounded,
                label: l.preferences,
                color: const Color(0xFF0D9488),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PreferencesScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsGroup(
            children: [
              SettingsRow(
                icon: Icons.auto_awesome_rounded,
                label: l.whatsNew,
                color: const Color(0xFFF2711C),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WhatsNewScreen()),
                ),
              ),
              SettingsRow(
                icon: Icons.feedback_rounded,
                label: l.feedback,
                color: const Color(0xFF8B5CF6),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                ),
              ),
              SettingsRow(
                icon: Icons.help_rounded,
                label: l.supportHelp,
                color: const Color(0xFF1D7BE8),
                onTap: _showSupport,
              ),
              SettingsRow(
                icon: Icons.info_rounded,
                label: l.aboutApp,
                color: scheme.onSurfaceVariant,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsGroup(
            children: [
              SettingsRow(
                icon: Icons.logout_rounded,
                label: l.logout,
                color: scheme.error,
                onTap: _logout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileEdit {
  const _ProfileEdit(this.name, this.photo);

  final String name;
  final Uint8List? photo;
}

class _EditProfileSheet extends StatefulWidget {
  const _EditProfileSheet({
    required this.name,
    required this.email,
    required this.photo,
    required this.canResetPassword,
  });

  final String name;
  final String email;
  final Uint8List? photo;
  final bool canResetPassword;

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late final TextEditingController _name = TextEditingController(text: widget.name);
  late Uint8List? _photo = widget.photo;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (mounted) setState(() => _photo = bytes);
    } catch (_) {}
  }

  Future<void> _sendReset() async {
    final l = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await AuthService.sendPasswordReset(widget.email);
      messenger.showSnackBar(SnackBar(content: Text(l.resetEmailSent(widget.email))));
    } on AuthException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(authErrorText(l, e))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(22, 0, 22, 18 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l.editProfile,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 18),
            Center(
              child: GestureDetector(
                onTap: _pickPhoto,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    UserAvatar(name: _name.text, bytes: _photo, radius: 46),
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: scheme.primary,
                      child: const Icon(Icons.photo_camera_rounded, size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l.nameLabel,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
            ),
            if (widget.canResetPassword) ...[
              const SizedBox(height: 14),
              TextField(
                controller: TextEditingController(text: widget.email),
                enabled: false,
                decoration: InputDecoration(
                  labelText: l.emailLabel,
                  helperText: l.emailCannotChange,
                  prefixIcon: const Icon(Icons.mail_outline_rounded),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _sendReset,
                  icon: const Icon(Icons.lock_reset_rounded),
                  label: Text(l.sendResetEmail),
                ),
              ),
            ],
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () => Navigator.pop(context, _ProfileEdit(_name.text.trim(), _photo)),
              child: Text(l.saveChanges),
            ),
          ],
        ),
      ),
    );
  }
}
