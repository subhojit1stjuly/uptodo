import 'package:flutter/material.dart';

/// screen for the changing the language
class ChangeLanguagePage extends StatefulWidget {
  /// constructor for the widget
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Language'),
        leading: BackButton(
          onPressed: () {

          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              // change the language to English
            },
          ),
          ListTile(
            title: const Text('Hindi'),
            onTap: () {
              // change the language to Hindi
            },
          ),
          ListTile(
            title: const Text('Spanish'),
            onTap: () {
              // change the language to Spanish
            },
          ),
        ],
      ),
    );
  }
}
