import 'package:flutter/material.dart';

import '../core/app_config.dart';
import '../l10n/l10n_helpers.dart';
import '../widgets/app_widgets.dart';
import 'privacy_policy.dart';
import 'terms_of_service.dart';
import 'whats_new_screen.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(l.aboutApp)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const SizedBox(height: 10),
          const Center(child: BrandBadge(icon: Icons.record_voice_over_rounded, size: 82)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              l.appName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              '${l.aboutVersion} ${AppConfig.version}',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 26),
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
                icon: Icons.privacy_tip_rounded,
                label: l.privacyPolicy,
                color: const Color(0xFF0D9488),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
                ),
              ),
              SettingsRow(
                icon: Icons.description_rounded,
                label: l.termsOfService,
                color: const Color(0xFF1D7BE8),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermsOfServiceScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
