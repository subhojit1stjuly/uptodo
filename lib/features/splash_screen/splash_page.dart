import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
/// This screen is used to show the Splash screen in the app
class SplashPage extends StatefulWidget {
  /// This is the Constructor
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Splash Page'),
    );
  }
}
