import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n_helpers.dart';

/// A long document (privacy policy, terms) rendered from markdown in the app's theme.
/// The documents are written in English only, and the page says so.
class LegalPage extends StatelessWidget {
  const LegalPage({super.key, required this.title, required this.markdown});

  final String title;
  final String markdown;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final showNote = Localizations.localeOf(context).languageCode != 'en';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showNote)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(Icons.translate_rounded, size: 18, color: scheme.primary),
                    const SizedBox(width: 10),
                    Expanded(child: Text(l.legalEnglishNote)),
                  ],
                ),
              ),
            MarkdownBody(
              data: markdown,
              styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                p: theme.textTheme.bodyLarge?.copyWith(height: 1.55),
                h3: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                strong: const TextStyle(fontWeight: FontWeight.w800),
                a: TextStyle(color: scheme.primary, decoration: TextDecoration.underline),
                horizontalRuleDecoration: BoxDecoration(
                  border: Border(top: BorderSide(color: scheme.outlineVariant)),
                ),
              ),
              onTapLink: (text, href, title) {
                if (href != null) launchUrl(Uri.parse(href));
              },
            ),
          ],
        ),
      ),
    );
  }
}
