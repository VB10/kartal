import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Widget chaining playground.
class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});

  @override
  State<WidgetsPage> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  var _isVisible = true;
  var _isDisabled = false;
  var _padding = 12.0;
  var _opacity = 1.0;
  var _radius = 8.0;
  var _quarterTurns = 0;
  var _taps = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = context.general.colorScheme;

    // The chain under demonstration, built from the live control values.
    final chained =
        Container(
              alignment: Alignment.center,
              color: scheme.primaryContainer,
              child: Text(
                'chained',
                style: TextStyle(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ).ext
            .sized(width: 160, height: 72)
            .ext
            .clipRounded(_radius)
            .ext
            .rotated(_quarterTurns)
            .ext
            .opacity(_opacity)
            .ext
            .paddingAll(_padding)
            .ext
            .toDisabled(disable: _isDisabled)
            .ext
            .toVisible(value: _isVisible);

    return GalleryBody(
      children: [
        DemoSection(
          title: 'Live chain',
          description:
              'Helpers compose left to right, so the last one applied ends up '
              'outermost.',
          snippet:
              'myWidget\n'
              '    .ext.sized(width: 160, height: 72)\n'
              '    .ext.clipRounded($_radius)\n'
              '    .ext.rotated($_quarterTurns)\n'
              '    .ext.opacity($_opacity)\n'
              '    .ext.paddingAll($_padding)\n'
              '    .ext.toDisabled(disable: $_isDisabled)\n'
              '    .ext.toVisible(value: $_isVisible);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Center(child: chained),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('toVisible', style: _labelStyle),
                value: _isVisible,
                onChanged: (value) => setState(() => _isVisible = value),
              ),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('toDisabled', style: _labelStyle),
                value: _isDisabled,
                onChanged: (value) => setState(() => _isDisabled = value),
              ),
              _SliderRow(
                label: 'paddingAll',
                value: _padding,
                max: 40,
                onChanged: (value) => setState(() => _padding = value),
              ),
              _SliderRow(
                label: 'opacity',
                value: _opacity,
                max: 1,
                onChanged: (value) => setState(() => _opacity = value),
              ),
              _SliderRow(
                label: 'clipRounded',
                value: _radius,
                max: 36,
                onChanged: (value) => setState(() => _radius = value),
              ),
              _SliderRow(
                label: 'rotated',
                value: _quarterTurns.toDouble(),
                max: 3,
                divisions: 3,
                onChanged: (value) =>
                    setState(() => _quarterTurns = value.round()),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'onTap',
          description:
              'InkWell by default for the ripple. Pass withRipple: false for '
              'a bare GestureDetector, which is what you want over an image.',
          snippet:
              "const Text('Tap me')\n"
              '    .ext.paddingAll(16)\n'
              '    .ext.card(elevation: 2)\n'
              '    .ext.onTap(onPressed);',
          child: Row(
            children: [
              const Text('Tap me').ext
                  .paddingAll(16)
                  .ext
                  .card(elevation: 2)
                  .ext
                  .onTap(() => setState(() => _taps++)),
              const SizedBox(width: 16),
              Text('$_taps taps', style: _labelStyle),
            ],
          ),
        ),
        DemoSection(
          title: 'Layout helpers',
          snippet:
              'child.ext.expanded(flex: 2);\n'
              'child.ext.flexible();\n'
              'child.ext.align(Alignment.topRight);',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    _Block(
                      label: 'flex 2',
                      color: scheme.primaryContainer,
                    ).ext.expanded(flex: 2),
                    _Block(
                      label: 'flex 1',
                      color: scheme.secondaryContainer,
                    ).ext.expanded(),
                    _Block(
                      label: 'flex 1',
                      color: scheme.tertiaryContainer,
                    ).ext.expanded(),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: SizedBox(
                  height: 72,
                  child: const Text('topRight').ext.align(Alignment.topRight),
                ),
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Stack(
                  children: [
                    const SizedBox(height: 72, width: double.infinity),
                    const Text('positioned').ext.positioned(right: 8, top: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'tooltip and hero',
          description: 'Hover or long-press the chip to see the tooltip.',
          snippet:
              "child.ext.tooltip('Extra detail');\n"
              "child.ext.hero('avatar');",
          child: Row(
            children: [
              const Chip(label: Text('Hover me')).ext.tooltip(
                'Attached with .ext.tooltip()',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Space boxes',
          description:
              'SpaceSizedHeightBox and SpaceSizedWidthBox take a fraction of '
              'the viewport rather than a fixed number of pixels.',
          snippet:
              'context.sized.emptySizedHeightBoxLow;   // 1% of height\n'
              'context.sized.emptySizedWidthBoxNormal; // 5% of width',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Block(label: 'A', color: scheme.primaryContainer),
                  context.sized.emptySizedWidthBoxLow,
                  _Block(label: 'B', color: scheme.primaryContainer),
                  context.sized.emptySizedWidthBoxNormal,
                  _Block(label: 'C', color: scheme.primaryContainer),
                ],
              ),
              ResultRow(
                label: 'low width',
                value: '${(context.sized.width * 0.01).toStringAsFixed(1)} px',
              ),
              ResultRow(
                label: 'normal width',
                value: '${(context.sized.width * 0.05).toStringAsFixed(1)} px',
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Image rotation',
          snippet: 'Image.network(url).ext.upRotation;',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final entry in <String, Widget>{
                'original': _demoImage,
                'upRotation': _demoImage.ext.upRotation,
                'rightRotation': _demoImage.ext.rightRotation,
                'bottomRotation': _demoImage.ext.bottomRotation,
              }.entries)
                Column(
                  children: [
                    SizedBox(width: 72, height: 72, child: entry.value),
                    const SizedBox(height: 4),
                    Text(entry.key, style: _labelStyle),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

const _labelStyle = TextStyle(fontFamily: 'monospace', fontSize: 12);

/// A small solid coloured block used to make layout helpers visible.
final _demoImage = Image.network(
  'https://picsum.photos/seed/kartal/200',
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) =>
      const ColoredBox(color: Colors.grey, child: Icon(Icons.image_outlined)),
);

class _Block extends StatelessWidget {
  const _Block({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    height: 44,
    width: 44,
    color: color,
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(fontSize: 11, color: color.ext.contrastText()),
    ),
  );
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.max,
    required this.onChanged,
    this.divisions,
  });

  final String label;
  final double value;
  final double max;
  final int? divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(width: 96, child: Text(label, style: _labelStyle)),
      Expanded(
        child: Slider(
          value: value,
          max: max,
          divisions: divisions,
          label: value.toStringAsFixed(divisions == null ? 1 : 0),
          onChanged: onChanged,
        ),
      ),
      SizedBox(
        width: 36,
        child: Text(
          value.toStringAsFixed(divisions == null ? 1 : 0),
          style: _labelStyle,
        ),
      ),
    ],
  );
}
