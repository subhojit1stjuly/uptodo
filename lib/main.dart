import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'features/splash_screen/splash_page.dart';

Future<void> main() async {
  ///  this ensures that the Flutter engine is properly initialized
  ///  if application logic needs to interact with the native platform (e.g., accessing device features)
  ///  even before building the UI, initializing the engine early , then this is crucial.
  WidgetsFlutterBinding.ensureInitialized();
  /// All errors caught by Flutter are routed to here
  /// Placing FlutterError.onError outside of runZonedGuarded is the generally recommended approach.
  /// This ensures that the global handler catches UI-related errors thrown by
  /// the Flutter framework itself, even if those errors occur outside
  /// of the zone created by runZonedGuarded.
  FlutterError.onError = (details) {
    debugPrint('Caught UI error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };
  /// If invokeMethod throws an error, it won't be forwarded to FlutterError.onError.
  /// Instead, it's forwarded to the PlatformDispatcher.
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Caught error: ${error.toString()}');
    debugPrint('Stack trace: ${stack.toString()}');
    return true;
  };
  /// running the entire application inside this Guarded Zone to stop unnecessary app crash.
  runZonedGuarded((){
    runApp(const UpTodo());
  },(error,StackTrace stack) {
    debugPrint('Caught error: ${error.toString()}');
    debugPrint('Stack trace: ${stack.toString()}');
  });
}
class UpTodo extends StatelessWidget {
  const UpTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocalizations.of(context)!.app_name,
      debugShowCheckedModeBanner: false,
      // Define the default locale. This will be used if the system's locale is not supported.
      locale: const Locale('en', 'US'),
      // Define supported locales
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('bn', 'IN'), // Bengali
        Locale('kn', 'IN'), // Kannada
        Locale('hi', 'IN'), // Hindi
        // Add more locales here
      ],
      localizationsDelegates: const [
        // Built-in localization for text direction LTR/RTL
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // Your custom delegate for app-specific localization
        AppLocalizations.delegate, // Add this line
      ],
      //TODO: need to re-visit (for testing)
      // Returns a locale which will be used if the system's locale is not supported.
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        // If the device's locale is not supported, use the first one from the list (default)
        return supportedLocales.first;
      },
      builder: _builder,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Use system theme mode (light/dark)
      home: const SplashPage(),
    );
  }
  //TODO: need to revisit (for re-design)
  Widget _builder(BuildContext context,Widget? widget){
    Widget error = const Text('...rendering error...');
    if (widget is Scaffold || widget is Navigator) {
      error = Scaffold(body: Center(child: error));
    }
    ErrorWidget.builder = (errorDetails) => error;
    if (widget != null) return widget;
    throw StateError('widget is null');
  }

}

