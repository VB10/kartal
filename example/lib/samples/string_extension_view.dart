import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StringExtensionView extends StatelessWidget {
  const StringExtensionView({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextFormField(
            validator: (value) => value.isNotNullOrNoEmpty ? null : 'fail',
          ),
          TextFormField(
            validator: (value) => value.isValidEmail ? null : 'fail',
          ),
          TextField(
            inputFormatters: [InputFormatter.instance.phoneFormatter],
            onChanged: (value) {
              if (kDebugMode) {
                print(value.phoneFormatValue);
              }
            },
          )
        ],
      );

  void shareWhatsApp(String value) {
    value.shareWhatsApp();
  }

  void openWeb(String value) {
    value.launchWebsite;
  }

  void bearerTokenHeader() {
    if (kDebugMode) {
      print('TOKEN-X-X-X'.bearer);
    }
  }
}
