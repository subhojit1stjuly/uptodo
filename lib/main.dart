import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: _builder,
      theme: ThemeData(
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
      ),
    );
  }

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

