import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../l10n/l10n_helpers.dart';
import 'auth_navigation.dart';

/// Lets someone try the app without an account: asks for an optional name, then
/// opens the app. Progress stays on this device.
Future<void> startAsGuest(BuildContext context) async {
  final name = await showDialog<String>(
    context: context,
    builder: (_) => const _GuestNameDialog(),
  );
  if (name == null || !context.mounted) return;
  await AppSettings.instance.setGuest(true, name: name.trim());
  await AppSettings.instance.markOnboardingSeen();
  if (context.mounted) goToHome(context);
}

class _GuestNameDialog extends StatefulWidget {
  const _GuestNameDialog();

  @override
  State<_GuestNameDialog> createState() => _GuestNameDialogState();
}

class _GuestNameDialogState extends State<_GuestNameDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return AlertDialog(
      title: Text(l.guestNameTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: l.guestNameHint),
            onSubmitted: (v) => Navigator.pop(context, v),
          ),
          const SizedBox(height: 12),
          Text(
            l.guestNote,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(110, 46)),
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text(l.start),
        ),
      ],
    );
  }
}
