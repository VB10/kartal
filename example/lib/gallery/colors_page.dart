import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Colour toolkit playground.
class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  static const _seeds = <Color>[
    Color(0xFF3F51B5),
    Color(0xFFE91E63),
    Color(0xFF4CAF50),
    Color(0xFFFFEB3B),
    Color(0xFF212121),
    Color(0xFFFAFAFA),
    Color(0xFF795548),
    Color(0xFF00BCD4),
  ];

  Color _selected = _seeds.first;
  final _hex = TextEditingController(text: '#3F51B5');
  var _randomSeed = 0;

  @override
  void dispose() {
    _hex.dispose();
    super.dispose();
  }

  void _select(Color color) => setState(() {
    _selected = color;
    _hex.text = color.ext.toHex(uppercase: true);
  });

  @override
  Widget build(BuildContext context) => GalleryBody(
    children: [
      DemoSection(
        title: 'Pick a colour',
        description: 'Everything below recomputes from this seed.',
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final seed in _seeds)
              _Swatch(
                color: seed,
                isSelected: seed == _selected,
                onTap: () => _select(seed),
              ),
          ],
        ),
      ),
      DemoSection(
        title: 'Hex parsing',
        description:
            'Accepts an optional leading # and either 6 digit RGB or 8 digit '
            'ARGB. tryParse reports failure instead of guessing.',
        snippet:
            "KartalColor.tryParse('${_hex.text}');\n"
            "color.ext.toHex();  // '${_selected.ext.toHex()}'",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _hex,
                    onChanged: (value) {
                      final parsed = KartalColor.tryParse(value);
                      if (parsed != null) setState(() => _selected = parsed);
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Hex',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
                const SizedBox(width: 12),
                VerdictChip(
                  isValid: KartalColor.tryParse(_hex.text) != null,
                  label: KartalColor.tryParse(_hex.text) != null
                      ? 'parsed'
                      : 'null',
                ),
              ],
            ),
            const SizedBox(height: 16),
            ResultRow(label: 'toHex()', value: _selected.ext.toHex()),
            ResultRow(
              label: 'toHex(includeAlpha: true)',
              value: _selected.ext.toHex(includeAlpha: true),
            ),
            ResultRow(
              label: 'toHex(uppercase: true)',
              value: _selected.ext.toHex(uppercase: true),
            ),
          ],
        ),
      ),
      DemoSection(
        title: 'Luminance and contrast',
        description:
            'isDark uses WCAG relative luminance, not a naive RGB average, so '
            'perceptually bright hues like yellow are correctly light. '
            'contrastText picks a readable foreground.',
        snippet:
            'color.ext.isDark;          // ${_selected.ext.isDark}\n'
            'color.ext.luminance;       '
            '// ${_selected.ext.luminance.toStringAsFixed(3)}\n'
            'color.ext.contrastText();',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContrastPreview(color: _selected),
            const SizedBox(height: 12),
            ResultRow(
              label: 'luminance',
              value: _selected.ext.luminance.toStringAsFixed(4),
            ),
            ResultRow(label: 'isDark', value: '${_selected.ext.isDark}'),
            ResultRow(label: 'isLight', value: '${_selected.ext.isLight}'),
            ResultRow(
              label: 'contrastText()',
              value: _selected.ext.contrastText().ext.toHex(),
            ),
          ],
        ),
      ),
      DemoSection(
        title: 'Lighten, darken and blend',
        snippet:
            'color.ext.lighten(0.2);\n'
            'color.ext.darken(0.2);\n'
            'color.ext.blend(Colors.white, 0.5);',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ColorStrip(
              label: 'lighten',
              colors: [
                for (var step = 0; step <= 4; step++)
                  _selected.ext.lighten(step * 0.1),
              ],
            ),
            const SizedBox(height: 8),
            _ColorStrip(
              label: 'darken',
              colors: [
                for (var step = 0; step <= 4; step++)
                  _selected.ext.darken(step * 0.1),
              ],
            ),
            const SizedBox(height: 8),
            _ColorStrip(
              label: 'blend → white',
              colors: [
                for (var step = 0; step <= 4; step++)
                  _selected.ext.blend(Colors.white, step * 0.25),
              ],
            ),
          ],
        ),
      ),
      DemoSection(
        title: 'Material swatch',
        description:
            'Builds a full 50..900 swatch from a single colour as shade 500, '
            'ready for a ThemeData primary swatch.',
        snippet: 'color.ext.toMaterialColor();',
        child: _SwatchStrip(swatch: _selected.ext.toMaterialColor()),
      ),
      DemoSection(
        title: 'Seeded random',
        description:
            'KartalColor.random takes a seed, so it is deterministic and '
            'testable. Every entry in Colors.primaries is reachable.',
        snippet: 'KartalColor.random(seed: $_randomSeed);',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var offset = 0; offset < 8; offset++)
                  _Swatch(
                    color: KartalColor.random(seed: _randomSeed + offset),
                    isSelected: false,
                    onTap: () =>
                        _select(KartalColor.random(seed: _randomSeed + offset)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => setState(() => _randomSeed += 8),
              icon: const Icon(Icons.casino_outlined),
              label: const Text('Next seeds'),
            ),
          ],
        ),
      ),
      const DemoSection(
        title: 'From a string',
        description: 'The same parser on a string receiver.',
        snippet:
            "'#FF0000'.ext.toColorOrNull;  // Color(0xFFFF0000)\n"
            "'nope'.ext.toColorOrNull;     // null\n"
            "'nope'.ext.toColor;           // white",
        child: _StringColorDemo(),
      ),
    ],
  );
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? context.general.colorScheme.primary
              : context.general.colorScheme.outlineVariant,
          width: isSelected ? 3 : 1,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, color: color.ext.contrastText())
          : null,
    ),
  );
}

class _ContrastPreview extends StatelessWidget {
  const _ContrastPreview({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Readable either way',
          style: TextStyle(
            color: color.ext.contrastText(),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'contrastText() chose '
          '${color.ext.isDark ? 'white' : 'black'} here',
          style: TextStyle(color: color.ext.contrastText(), fontSize: 12),
        ),
      ],
    ),
  );
}

class _ColorStrip extends StatelessWidget {
  const _ColorStrip({required this.label, required this.colors});

  final String label;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 100,
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Row(
            children: [
              for (final color in colors)
                Expanded(
                  child: ColoredBox(
                    color: color,
                    child: const SizedBox(height: 36),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

class _SwatchStrip extends StatelessWidget {
  const _SwatchStrip({required this.swatch});

  final MaterialColor swatch;

  @override
  Widget build(BuildContext context) {
    const shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          for (final shade in shades)
            Expanded(
              child: ColoredBox(
                color: swatch[shade]!,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      '$shade',
                      style: TextStyle(
                        fontSize: 9,
                        color: swatch[shade]!.ext.contrastText(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StringColorDemo extends StatelessWidget {
  const _StringColorDemo();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ResultRow(
        label: "'#FF0000'.toColorOrNull",
        value: '${'#FF0000'.ext.toColorOrNull}',
      ),
      ResultRow(
        label: "'nope'.toColorOrNull",
        value: '${'nope'.ext.toColorOrNull}',
      ),
      ResultRow(label: "'nope'.toColor", value: '${'nope'.ext.toColor}'),
    ],
  );
}
