import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

/// Numeric and string formatting playground.
class FormattersPage extends StatefulWidget {
  const FormattersPage({super.key});

  @override
  State<FormattersPage> createState() => _FormattersPageState();
}

class _FormattersPageState extends State<FormattersPage> {
  final _number = TextEditingController(text: '1234567');
  final _bytes = TextEditingController(text: '1536000');
  final _text = TextEditingController(
    text: 'Çok Güzel Bir Başlık — kartal makes Flutter nicer',
  );

  var _seconds = 3907.0;

  @override
  void dispose() {
    _number.dispose();
    _bytes.dispose();
    _text.dispose();
    super.dispose();
  }

  num get _value => num.tryParse(_number.text) ?? 0;
  int get _byteValue => int.tryParse(_bytes.text) ?? 0;

  @override
  Widget build(BuildContext context) => GalleryBody(
    children: [
      DemoSection(
        title: 'Compact and currency',
        description:
            'Implemented without intl, so the package stays dependency light.',
        snippet:
            '$_value.ext.compact();\n'
            "$_value.ext.currency(symbol: '₺', symbolOnLeft: false,\n"
            "    thousandSeparator: '.', decimalSeparator: ',');",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _number,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d.\-]')),
              ],
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 16),
            ResultRow(label: 'compact()', value: _value.ext.compact()),
            ResultRow(
              label: 'compact(decimals: 2)',
              value: _value.ext.compact(decimals: 2),
            ),
            ResultRow(label: 'currency()', value: _value.ext.currency()),
            ResultRow(
              label: 'currency(TR style)',
              value: _value.ext.currency(
                symbol: '₺',
                symbolOnLeft: false,
                thousandSeparator: '.',
                decimalSeparator: ',',
              ),
            ),
            ResultRow(
              label: r'currency(symbol: $)',
              value: _value.ext.currency(symbol: r'$'),
            ),
            ResultRow(label: 'percent()', value: _value.ext.percent()),
            ResultRow(label: 'fraction()', value: _value.ext.fraction()),
            if (_value is int)
              ResultRow(label: 'ordinal', value: (_value as int).ext.ordinal),
          ],
        ),
      ),
      DemoSection(
        title: 'File size',
        description: 'Binary units, dropping a trailing .0.',
        snippet: '$_byteValue.ext.readableFileSize;',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _bytes,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Bytes',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            const SizedBox(height: 16),
            ResultRow(
              label: 'readableFileSize',
              value: _byteValue.ext.readableFileSize,
            ),
            ResultRow(
              label: 'decimals: 2',
              value: _byteValue.ext.readableFileSizeWith(decimals: 2),
            ),
          ],
        ),
      ),
      DemoSection(
        title: 'Duration',
        description:
            'mm:ss below an hour, promoting to hh:mm:ss above it. Drag to see '
            'the switch.',
        snippet:
            '${_seconds.round()}.ext.seconds.ext.formatted;\n'
            'await 300.ext.ms.ext.delay();',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Slider(
              value: _seconds,
              max: 7200,
              divisions: 240,
              label: _seconds.round().ext.seconds.ext.formatted,
              onChanged: (value) => setState(() => _seconds = value),
            ),
            ResultRow(
              label: 'formatted',
              value: _seconds.round().ext.seconds.ext.formatted,
            ),
            ResultRow(
              label: 'format(forceHours: true)',
              value: _seconds.round().ext.seconds.ext.format(forceHours: true),
            ),
            ResultRow(
              label: 'as Duration',
              value: _seconds.round().ext.seconds.toString(),
            ),
          ],
        ),
      ),
      DemoSection(
        title: 'Text shaping',
        description:
            'toSlug folds diacritics first, so Turkish text survives. '
            'truncate counts the ellipsis inside the budget rather than '
            'appending past it.',
        snippet:
            'text.ext.toSlug();\n'
            'text.ext.truncate(24);\n'
            'text.ext.initials();',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _text,
              maxLines: 2,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Text',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 16),
            ResultRow(label: 'toSlug()', value: _text.text.ext.toSlug()),
            ResultRow(
              label: 'truncate(24)',
              value: _text.text.ext.truncate(24),
            ),
            ResultRow(label: 'initials()', value: _text.text.ext.initials()),
            ResultRow(
              label: 'initials(count: 4)',
              value: _text.text.ext.initials(count: 4),
            ),
            ResultRow(
              label: 'toTitleCase()',
              value: _text.text.ext.toTitleCase(),
            ),
            ResultRow(label: 'searchable', value: _text.text.ext.searchable),
            ResultRow(
              label: 'wordCount',
              value: '${_text.text.ext.wordCount}',
            ),
            ResultRow(
              label: 'readingTimeMinutes',
              value: '${_text.text.ext.readingTimeMinutes} min',
            ),
            ResultRow(label: 'reversed', value: _text.text.ext.reversed),
            ResultRow(
              label: 'base64Encoded',
              value: _text.text.ext.base64Encoded.ext.truncate(40),
            ),
            ResultRow(label: 'mask()', value: _text.text.ext.mask()),
          ],
        ),
      ),
      const DemoSection(
        title: 'HTML',
        description:
            'Uses the html parser rather than a regex, so entities decode '
            'correctly.',
        snippet:
            "'<p>Tom &amp; Jerry</p>'.ext.removeHtmlTags;  // 'Tom & Jerry'",
        child: _HtmlDemo(),
      ),
    ],
  );
}

class _HtmlDemo extends StatelessWidget {
  const _HtmlDemo();

  @override
  Widget build(BuildContext context) {
    const html = '<p>Tom &amp; Jerry went to <b>Istanbul</b> &lt;3</p>';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResultRow(label: 'input', value: html),
        ResultRow(label: 'removeHtmlTags', value: html.ext.removeHtmlTags),
      ],
    );
  }
}
