import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Kartal Extension Application')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImageRotate(),
            // buildContainerPaddingAndHeight(context),
            // buildTextFormFieldValid(),
            // buildContainerRandomColor(context),
            // buildImageRotate(),
            // buildTextFieldFormatter()
          ],
        ),
      ),
    );
  }

  /// [Input Formatter] Validation
  ///
  /// [String] value mask and unmask
  TextField buildTextFieldFormatter() {
    return TextField(
      inputFormatters: [InputFormatter.instance.phoneFormatter],
      onChanged: (value) {
        print(value.phoneFormatValue);
      },
    );
  }

  /// [Context] Helper
  ///
  /// Padding, height etc. direct acess and use centrically for app

  Container buildContainerPaddingAndHeight(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      height: context.dynamicHeight(0.1),
      width: context.dynamicWidth(0.5),
      color: context.randomColor,
      child: Text('Hello World'),
    );
  }

  /// [String] Validator
  ///
  /// Need validation for your field, use to "stirng.isValidEmail"
  TextFormField buildTextFormFieldValid() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: (value) => value.isValidEmail ? null : 'OH NOO',
    );
  }

  /// [Color] Generator
  ///
  /// Need draw any color for widget, just call [context.randomColor]
  Container buildContainerRandomColor(BuildContext context) {
    return Container(
      color: context.randomColor,
      child: Text('Hello World'),
    );
  }

  /// [Image] Rotation
  ///
  /// You can rorate right, left, top, bottom any image widget.

  Widget buildImageRotate() =>
      Image.network('https://picsum.photos/200/300').upRotation;
}
