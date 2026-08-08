import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

/// A scrollable page body with a consistent max width and padding.
///
/// Uses `context.padding` and `context.device.responsive` so the gallery
/// chrome is itself built out of the package it documents.
class GalleryBody extends StatelessWidget {
  const GalleryBody({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 820),
      child: ListView(
        padding: context.padding.normal,
        children: [
          ...children,
          // Leaves room above the bottom navigation bar on phones.
          const SizedBox(height: 48),
        ],
      ),
    ),
  );
}

/// A titled card grouping one feature, with the source snippet underneath.
class DemoSection extends StatelessWidget {
  const DemoSection({
    required this.title,
    required this.child,
    this.description,
    this.snippet,
    super.key,
  });

  final String title;
  final String? description;
  final Widget child;
  final String? snippet;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
      padding: context.padding.normal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.general.textTheme.titleMedium),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: context.general.textTheme.bodySmall?.copyWith(
                color: context.general.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 16),
          child,
          if (snippet != null) ...[
            const SizedBox(height: 16),
            CodeSnippet(snippet!),
          ],
        ],
      ),
    ),
  );
}

/// A monospace code block with a copy button.
class CodeSnippet extends StatelessWidget {
  const CodeSnippet(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    final scheme = context.general.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SelectableText(
                code.trim(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Copy',
              iconSize: 18,
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: code.trim()));
                if (!context.mounted) return;
                context.overlay.showSnack('Copied');
              },
              icon: const Icon(Icons.copy_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single `label -> value` row, used to show computed output.
class ResultRow extends StatelessWidget {
  const ResultRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isMonospace = true,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isMonospace;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 168,
          child: Text(
            label,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: isMonospace ? 'monospace' : null,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    ),
  );
}

/// A pass/fail chip for validator output.
class VerdictChip extends StatelessWidget {
  const VerdictChip({required this.isValid, this.label, super.key});

  final bool isValid;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final scheme = context.general.colorScheme;
    // The chip's foreground is chosen by the contrast helper rather than
    // hardcoded, so it stays readable in both themes.
    final background = isValid ? Colors.green : scheme.error;

    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: background,
      side: BorderSide.none,
      avatar: Icon(
        isValid ? Icons.check : Icons.close,
        size: 16,
        color: background.ext.contrastText(),
      ),
      label: Text(
        label ?? (isValid ? 'valid' : 'invalid'),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: background.ext.contrastText(),
        ),
      ),
    );
  }
}
