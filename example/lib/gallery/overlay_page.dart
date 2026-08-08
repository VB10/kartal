import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Overlay, loader and date playground.
class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  String? _lastResult;
  var _isTurkish = false;

  @override
  Widget build(BuildContext context) {
    final label = _isTurkish
        ? const DateLocalizationLabel.tr()
        : const DateLocalizationLabel();

    return GalleryBody(
      children: [
        DemoSection(
          title: 'Snack bars',
          snippet:
              "context.overlay.showSnack('Saved');\n"
              'context.overlay.hideSnack();',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: () => context.overlay.showSnack('Saved'),
                child: const Text('showSnack'),
              ),
              FilledButton.tonal(
                onPressed: () => context.overlay.showSnack(
                  'Item deleted',
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => setState(() => _lastResult = 'undone'),
                  ),
                ),
                child: const Text('with action'),
              ),
              OutlinedButton(
                onPressed: () => context.overlay.hideSnack(),
                child: const Text('hideSnack'),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Confirmation',
          description:
              'Completes with false rather than null when dismissed, so the '
              'result is usable directly in an if.',
          snippet:
              'final confirmed = await context.overlay.showConfirm(\n'
              "  title: 'Delete this item?',\n"
              "  confirmLabel: 'Delete',\n"
              '  isDestructive: true,\n'
              ');\n'
              'if (confirmed) await delete();',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledButton.tonal(
                onPressed: () async {
                  final confirmed = await context.overlay.showConfirm(
                    title: 'Delete this item?',
                    message: 'This cannot be undone.',
                    confirmLabel: 'Delete',
                    isDestructive: true,
                  );

                  if (!mounted) return;
                  setState(() => _lastResult = 'showConfirm → $confirmed');
                },
                child: const Text('showConfirm'),
              ),
              if (_lastResult != null) ...[
                const SizedBox(height: 12),
                ResultRow(label: 'result', value: _lastResult!),
              ],
            ],
          ),
        ),
        DemoSection(
          title: 'Bottom sheet',
          description:
              'isScrollControlled defaults to true, so a sheet with a field '
              'or a long list sizes correctly above the keyboard.',
          snippet: 'await context.overlay.showSheet(const FilterSheet());',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: () async {
                  final picked = await context.overlay.showSheet<String>(
                    const _PickerSheet(),
                  );

                  if (!mounted) return;
                  setState(
                    () => _lastResult = 'showSheet → ${picked ?? 'dismissed'}',
                  );
                },
                child: const Text('showSheet'),
              ),
              FilledButton.tonal(
                onPressed: () => context.overlay.showDialogCustom<void>(
                  const AlertDialog(
                    title: Text('showDialogCustom'),
                    content: Text('Any widget, wrapped in a modal route.'),
                  ),
                ),
                child: const Text('showDialogCustom'),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Loader',
          description:
              'Managers are held per NavigatorState, so a loader shown before '
              'a route change does not strand the next hideLoader on a dead '
              'navigator. hideLoader is a no-op when nothing is showing.',
          snippet:
              'context.popupManager.showLoader();\n'
              'context.popupManager.hideLoader();\n'
              '\n'
              '// Safe from a finally block:\n'
              'try {\n'
              '  await save();\n'
              '} finally {\n'
              '  context.popupManager.hideLoader();\n'
              '}',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: () async {
                  context.popupManager.showLoader();
                  await Future<void>.delayed(const Duration(seconds: 2));
                  if (!context.mounted) return;
                  context.popupManager.hideLoader();
                },
                child: const Text('showLoader (2s)'),
              ),
              FilledButton.tonal(
                onPressed: () async {
                  context.popupManager.showLoader(
                    id: 'custom',
                    widgetBuilder: (_) => const Card(
                      margin: EdgeInsets.symmetric(horizontal: 48),
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text('Uploading…'),
                          ],
                        ),
                      ),
                    ),
                  );
                  await Future<void>.delayed(const Duration(seconds: 2));
                  if (!context.mounted) return;
                  context.popupManager.hideLoader(id: 'custom');
                },
                child: const Text('custom loader'),
              ),
              OutlinedButton(
                // Demonstrates that this does not throw.
                onPressed: () {
                  context.popupManager.hideLoader();
                  context.overlay.showSnack('hideLoader with nothing showing');
                },
                child: const Text('hideLoader (nothing shown)'),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Relative time',
          description:
              'A null receiver returns emptyLabel rather than throwing, and '
              'sub-second or future timestamps return justNowLabel.',
          snippet: _isTurkish
              ? 'date.ext.differenceTime(\n'
                    '  localizationLabel: const DateLocalizationLabel.tr(),\n'
                    ');'
              : 'date.ext.differenceTime();',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'DateLocalizationLabel.tr()',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
                value: _isTurkish,
                onChanged: (value) => setState(() => _isTurkish = value),
              ),
              const SizedBox(height: 8),
              for (final entry in <String, Duration>{
                '2 years': const Duration(days: 730),
                '2 months': const Duration(days: 60),
                '3 days': const Duration(days: 3),
                '5 hours': const Duration(hours: 5),
                '10 minutes': const Duration(minutes: 10),
                '30 seconds': const Duration(seconds: 30),
                'now': Duration.zero,
              }.entries)
                ResultRow(
                  label: entry.key,
                  value: DateTime.now()
                      .subtract(entry.value)
                      .ext
                      .differenceTime(localizationLabel: label),
                ),
              ResultRow(
                label: 'null date',
                value:
                    '(empty) '
                    '${_nullDate.ext.differenceTime(localizationLabel: label)}',
              ),
              ResultRow(
                label: 'future date',
                value: DateTime.now()
                    .add(const Duration(days: 3))
                    .ext
                    .differenceTime(localizationLabel: label),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static const DateTime? _nullDate = null;
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet();

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: context.padding.normal,
          child: Text(
            'Pick one',
            style: context.general.textTheme.titleMedium,
          ),
        ),
        for (final option in ['Istanbul', 'Ankara', 'İzmir'])
          ListTile(
            title: Text(option),
            onTap: () => Navigator.of(context).pop(option),
          ),
        const SizedBox(height: 8),
      ],
    ),
  );
}
