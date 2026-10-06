import 'package:flutter/material.dart';

import '../core/app_config.dart';
import '../core/app_theme.dart';
import '../l10n/l10n_helpers.dart';

/// What changed in this release.
class WhatsNewScreen extends StatelessWidget {
  const WhatsNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final items = [
      (Icons.record_voice_over_rounded, const Color(0xFF5B5FEF), l.wn1),
      (Icons.spellcheck_rounded, const Color(0xFF0D9488), l.wn2),
      (Icons.local_fire_department_rounded, const Color(0xFFF97316), l.wn3),
      (Icons.palette_rounded, const Color(0xFFE11D74), l.wn4),
      (Icons.key_off_rounded, const Color(0xFF1D7BE8), l.wn5),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.whatsNew)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: scheme.brandGradient,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 30),
                const SizedBox(width: 14),
                Text(
                  '${l.aboutVersion} ${AppConfig.version}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (final (icon, color, text) in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.panel,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: scheme.hairline),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(width: 14),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(text, style: const TextStyle(height: 1.4, fontSize: 15)),
                      ),
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
