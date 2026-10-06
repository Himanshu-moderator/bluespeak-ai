import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/languages.dart';
import '../l10n/l10n_helpers.dart';
import '../widgets/app_widgets.dart';

/// Themes, accent colours, languages and voice.
class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  Future<void> _pickLanguage(
    BuildContext context, {
    required String title,
    required String current,
    required ValueChanged<String> onPick,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              for (final lang in supportedLanguages)
                ListTile(
                  title: Text(
                    lang.nativeName,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: lang.nativeName == lang.englishName ? null : Text(lang.englishName),
                  trailing: lang.code == current
                      ? Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () {
                    onPick(lang.code);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final settings = AppSettings.instance;

    return Scaffold(
      appBar: AppBar(title: Text(l.preferences)),
      body: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            children: [
              SectionHeader(l.prefsAppearance),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.prefsTheme, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<ThemeMode>(
                          showSelectedIcon: false,
                          segments: [
                            ButtonSegment(
                              value: ThemeMode.system,
                              icon: const Icon(Icons.brightness_auto_rounded, size: 18),
                              label: Text(l.themeSystem),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: const Icon(Icons.light_mode_rounded, size: 18),
                              label: Text(l.themeLight),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: const Icon(Icons.dark_mode_rounded, size: 18),
                              label: Text(l.themeDark),
                            ),
                          ],
                          selected: {settings.themeMode},
                          onSelectionChanged: (s) => settings.setThemeMode(s.first),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(l.prefsAccent, style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          for (final a in accentOptions)
                            _AccentDot(
                              option: a,
                              label: accentLabel(l, a.id),
                              selected: settings.accentId == a.id,
                              onTap: () => settings.setAccent(a.id),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SectionHeader(l.prefsLanguage),
              SettingsGroup(
                children: [
                  SettingsRow(
                    icon: Icons.translate_rounded,
                    label: l.prefsAppLanguage,
                    value: languageFor(settings.uiLang).nativeName,
                    onTap: () => _pickLanguage(
                      context,
                      title: l.prefsAppLanguage,
                      current: settings.uiLang,
                      onPick: settings.setUiLang,
                    ),
                  ),
                  SettingsRow(
                    icon: Icons.record_voice_over_rounded,
                    label: l.prefsPracticeLanguage,
                    value: languageFor(settings.practiceLang).nativeName,
                    color: const Color(0xFF0D9488),
                    onTap: () => _pickLanguage(
                      context,
                      title: l.prefsPracticeLanguage,
                      current: settings.practiceLang,
                      onPick: settings.setPracticeLang,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                child: Text(
                  '${l.prefsAppLanguageHelp}\n${l.prefsPracticeHelp}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ),
              SectionHeader(l.prefsDefaultLevel),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<String>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(value: 'beginner', label: Text(l.levelBeginner)),
                        ButtonSegment(value: 'intermediate', label: Text(l.levelIntermediate)),
                        ButtonSegment(value: 'advanced', label: Text(l.levelAdvanced)),
                      ],
                      selected: {settings.level},
                      onSelectionChanged: (s) => settings.setLevel(s.first),
                    ),
                  ),
                ),
              ),
              SectionHeader(l.prefsVoice),
              SettingsGroup(
                children: [
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    secondary: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.volume_up_rounded, color: scheme.primary, size: 21),
                    ),
                    title: Text(
                      l.prefsAutoSpeak,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(l.prefsAutoSpeakHelp),
                    value: settings.autoSpeak,
                    onChanged: settings.setAutoSpeak,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({
    required this.option,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final AccentOption option;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          width: 64,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: option.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? scheme.onSurface : Colors.transparent,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: option.color.withValues(alpha: selected ? 0.5 : 0.2),
                      blurRadius: selected ? 14 : 6,
                    ),
                  ],
                ),
                child: selected
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 24)
                    : null,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
