import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_config.dart';
import '../l10n/l10n_helpers.dart';
import 'privacy_policy.dart';
import 'terms_of_service.dart';

class _Shot {
  const _Shot(this.path, this.bytes);

  final String path;
  final Uint8List bytes;
}

/// Sends feedback by email (with optional screenshots on mobile).
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

// Observes the app lifecycle to detect the user coming back from the email app.
class _FeedbackScreenState extends State<FeedbackScreen> with WidgetsBindingObserver {
  final _text = TextEditingController();
  final _picker = ImagePicker();
  final List<_Shot> _shots = [];
  bool _mayEmail = false;
  bool _sent = false;
  bool _emailLaunched = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _text.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _emailLaunched) {
      setState(() {
        _sent = true;
        _emailLaunched = false;
      });
    }
  }

  void _snack(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _pickShots() async {
    final l = context.l10n;
    if (_shots.length >= 2) {
      _snack(l.fbMaxTwo);
      return;
    }
    try {
      final picked = await _picker.pickMultiImage(maxWidth: 1600, imageQuality: 80);
      for (final f in picked) {
        if (_shots.length >= 2) break;
        _shots.add(_Shot(f.path, await f.readAsBytes()));
      }
      if (mounted) setState(() {});
      if (picked.length > 2) _snack(l.fbMaxTwo);
    } catch (_) {
      // picker closed or unavailable
    }
  }

  Future<void> _send() async {
    final l = context.l10n;
    if (_text.text.trim().isEmpty) {
      _snack(l.fbEmpty);
      return;
    }

    final body =
        'Feedback from BlueSpeak AI user:\n\n${_text.text}\n\n'
        'Receive future updates: ${_mayEmail ? 'Yes' : 'No'}\n';
    const subject = 'BlueSpeak AI Feedback';

    try {
      if (kIsWeb) {
        // The email-sender plugin is mobile-only; on the web open a mailto: link.
        final mailto = Uri(
          scheme: 'mailto',
          path: AppConfig.supportEmail,
          query: Uri(queryParameters: {'subject': subject, 'body': body}).query.replaceAll('+', '%20'),
        );
        if (!await launchUrl(mailto)) throw Exception('No email clients found');
        setState(() => _sent = true);
        return;
      }
      await FlutterEmailSender.send(
        Email(
          body: body,
          subject: subject,
          recipients: [AppConfig.supportEmail],
          attachmentPaths: _shots.map((s) => s.path).toList(),
          isHTML: false,
        ),
      );
      _emailLaunched = true;
      if (mounted) _snack(l.fbOpening);
    } catch (_) {
      _emailLaunched = false;
      if (mounted) _snack(l.fbCouldNotOpen(AppConfig.supportEmail));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    if (_sent) {
      return Scaffold(
        appBar: AppBar(title: Text(l.fbSentTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/thank_you.png', height: 230, fit: BoxFit.contain),
                const SizedBox(height: 18),
                Text(
                  l.fbThanks,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  l.fbThanksBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 26),
                FilledButton(onPressed: () => Navigator.pop(context), child: Text(l.done)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.feedback)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          Text(
            l.fbDescribe,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _text,
            minLines: 5,
            maxLines: 9,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(hintText: l.fbHint),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 15, color: scheme.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  l.fbNoSensitive,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            l.fbScreenshotHelp,
            style: TextStyle(color: scheme.onSurfaceVariant, height: 1.35),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _pickShots,
            icon: const Icon(Icons.attach_file_rounded),
            label: Text(l.fbUpload),
          ),
          if (_shots.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < _shots.length; i++)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.memory(_shots[i].bytes, width: 100, height: 100, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => setState(() => _shots.removeAt(i)),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.close_rounded, size: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: _mayEmail,
            onChanged: (v) => setState(() => _mayEmail = v ?? false),
            title: Text(l.fbMayEmail, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 4),
          Text(
            l.fbPrivacyNote,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          Wrap(
            children: [
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
                ),
                child: Text(l.privacyPolicy),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermsOfServiceScreen()),
                ),
                child: Text(l.termsOfService),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: _send,
            icon: const Icon(Icons.send_rounded, size: 20),
            label: Text(l.fbSend),
          ),
        ],
      ),
    );
  }
}
