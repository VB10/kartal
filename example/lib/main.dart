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
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: context.paddingAllLow,
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(0.5),
              color: context.randomColor,
              child: Text('Hello World'),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              validator: (value) => value.isValidEmail ? null : "OH NOO",
            ),
            Container(
              color: context.randomColor,
              child: Text('Hello World'),
            ),
            Container(
              color: context.randomColor,
              child: Text('Hello World'),
            ),
            Image.network("https://picsum.photos/200/300").upRotation
          ],
        ),
      ),
    );
  }
}
