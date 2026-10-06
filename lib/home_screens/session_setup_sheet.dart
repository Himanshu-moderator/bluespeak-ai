import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../coach/coach_models.dart';
import '../core/app_settings.dart';
import '../core/languages.dart';
import '../l10n/l10n_helpers.dart';

/// Shows the "set up your session" sheet for a room. Returns null if dismissed.
Future<SessionSetup?> showSessionSetup(
  BuildContext context,
  RoomInfo room, {
  String? presetScenarioId,
}) {
  return showModalBottomSheet<SessionSetup>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _SetupSheet(room: room, presetScenarioId: presetScenarioId),
  );
}

class _SetupSheet extends StatefulWidget {
  const _SetupSheet({required this.room, this.presetScenarioId});

  final RoomInfo room;
  final String? presetScenarioId;

  @override
  State<_SetupSheet> createState() => _SetupSheetState();
}

class _SetupSheetState extends State<_SetupSheet> {
  late String? _scenarioId =
      widget.presetScenarioId ??
      (widget.room.scenarios.isEmpty ? null : widget.room.scenarios.first.id);
  late String _level = AppSettings.instance.level;
  late String _practiceLang = AppSettings.instance.practiceLang;
  final _roleController = TextEditingController();
  PhotoAttachment? _photo;
  String? _error;

  @override
  void dispose() {
    _roleController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 75,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      final mime = file.mimeType ?? lookupMimeType(file.name, headerBytes: bytes) ?? 'image/jpeg';
      if (!const ['image/jpeg', 'image/png', 'image/webp'].contains(mime)) return;
      final data = base64Encode(bytes);
      if (!mounted) return;
      if (data.length > 5500000) {
        setState(() => _error = context.l10n.errTooLarge);
        return;
      }
      setState(() {
        _photo = PhotoAttachment(mimeType: mime, base64Data: data, bytes: bytes);
        _error = null;
      });
    } catch (_) {
      // picker closed or not available: nothing to do
    }
  }

  void _start() {
    final l = context.l10n;
    final room = widget.room;
    if (room.needsPhoto && _photo == null) {
      setState(() => _error = l.setupNeedPhoto);
      return;
    }

    var prompt = '';
    var label = '';
    if (room.customRole && _roleController.text.trim().isNotEmpty) {
      prompt = label = _roleController.text.trim();
    } else if (_scenarioId != null) {
      final s = room.scenarios.firstWhere((s) => s.id == _scenarioId);
      prompt = s.prompt;
      label = scenarioLabel(l, s.id);
    }

    AppSettings.instance
      ..setLevel(_level)
      ..setPracticeLang(_practiceLang);

    Navigator.pop(
      context,
      SessionSetup(
        room: room.room,
        scenario: prompt,
        scenarioLabel: label,
        level: _level,
        practiceLang: _practiceLang,
        photo: _photo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final room = widget.room;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(22, 0, 22, 18 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: room.color.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(room.icon, color: room.color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomName(l, room.room),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        roomDescription(l, room.room),
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            if (room.needsPhoto) ...[
              Text(l.setupAddPhoto, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 10),
              if (_photo != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.memory(
                    _photo!.bytes,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              if (_photo != null) const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                      onPressed: () => _pickPhoto(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_rounded),
                      label: Text(l.setupFromGallery, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                      onPressed: () => _pickPhoto(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera_rounded),
                      label: Text(l.setupTakePhoto, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ] else ...[
              Text(
                room.customRole ? l.setupRoleLabel : l.setupChooseSituation,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              if (room.customRole) ...[
                TextField(
                  controller: _roleController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(hintText: l.setupRoleHint),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 10),
              ],
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in room.scenarios)
                    ChoiceChip(
                      label: Text(scenarioLabel(l, s.id)),
                      selected:
                          _scenarioId == s.id &&
                          !(room.customRole && _roleController.text.trim().isNotEmpty),
                      onSelected: (_) => setState(() {
                        _scenarioId = s.id;
                        _roleController.clear();
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],

            Text(l.setupLevel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(value: 'beginner', label: Text(l.levelBeginner)),
                  ButtonSegment(value: 'intermediate', label: Text(l.levelIntermediate)),
                  ButtonSegment(value: 'advanced', label: Text(l.levelAdvanced)),
                ],
                selected: {_level},
                onSelectionChanged: (s) => setState(() => _level = s.first),
              ),
            ),
            const SizedBox(height: 20),

            Text(l.setupPracticeIn, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final lang in supportedLanguages)
                  ChoiceChip(
                    label: Text(lang.nativeName),
                    selected: _practiceLang == lang.code,
                    onSelected: (_) => setState(() => _practiceLang = lang.code),
                  ),
              ],
            ),

            if (_error != null) ...[
              const SizedBox(height: 14),
              Text(_error!, style: TextStyle(color: scheme.error)),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _start,
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(l.setupStart),
            ),
          ],
        ),
      ),
    );
  }
}
