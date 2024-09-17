import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'src/future_extension_view.dart';

void main() {
  _appInit();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      const MaterialApp(title: 'Material App', home: HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                // File([], 'a.jpg').ext.fileType;
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.red),
            ),
          ],
        ),
        // appBar: AppBar(title: Text('Kartal Extension Application')),
        body: ListUserSearch(),
      );

  /// [Input Formatter] Validation
  ///
  /// [String] value mask and unmask
  Widget buildTextFieldFormatter() => TextField(
        inputFormatters: [InputFormatter.instance.phoneFormatter],
        onChanged: (value) {
          if (kDebugMode) {
            print(value.ext.phoneFormatValue);
          }
        },
      );

  /// [BuildContext] Helper
  ///
  /// Padding, height etc. direct access and use centrally for app

  Widget buildContainerPaddingAndHeight(BuildContext context) => Container(
        padding: context.padding.low,
        height: context.sized.dynamicHeight(0.1),
        width: context.sized.dynamicWidth(0.5),
        color: context.general.randomColor,
        child: const Text('Hello World'),
      );

  /// [String] Validator
  ///
  /// Need validation for your field, use to "string.isValidEmail"
  TextFormField buildTextFormFieldValid() => TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: (value) => value.ext.isValidEmail ? null : 'OH NOO',
      );

  /// [Color] Generator
  ///
  /// Need draw any color for widget, just call context.randomColor
  ColoredBox buildContainerRandomColor(BuildContext context) => ColoredBox(
        color: context.general.randomColor,
        child: const Text('Hello World'),
      );

  /// [Image] Rotation
  ///
  /// You can rotate right, left, top, bottom any image widget.

  Widget buildImageRotate() =>
      Image.network('https://picsum.photos/200/300').ext.upRotation;
}

void _appInit() {
  WidgetsFlutterBinding.ensureInitialized();
}

class ListUserSearch extends StatelessWidget {
  ListUserSearch({super.key});
  final List<String> sampleWords = [
    "Helloş ±Worldö",
    "wÖrldİ",
    "Flütter world",
  ];
  @override
  Widget build(BuildContext context) {
    const search = 'world';
    final results = sampleWords
        .where(
            (element) => element.ext.searchable.contains(search.ext.searchable))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(results[index]),
      ),
    );
  }
}
