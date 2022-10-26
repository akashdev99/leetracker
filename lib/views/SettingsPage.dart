import 'package:flutter/material.dart';

import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(8), children: <Widget>[
      //TODO: remove - test code
      // https://blog.logrocket.com/theming-your-app-flutter-guide/
      Center(
        child: RawMaterialButton(
          child: const Text(
            'Switch Modes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            AdaptiveTheme.of(context).toggleThemeMode();
          },
          fillColor: Colors.green,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ]);
  }
}
