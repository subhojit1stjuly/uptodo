import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/locale_constants.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/errors/app_error_handler.dart';
import 'package:uptodo/core/theme/dark_theme.dart';
import 'package:uptodo/core/theme/light_theme.dart';
import 'package:uptodo/features/authentication/presentation/bloc/session_bloc.dart';
import 'package:uptodo/features/authentication/presentation/bloc/state/session_state.dart';

Future<void> main() async {
  /// initializing the error handler
  AppErrorHandler.initialize();

  /// running the entire application inside this Guarded Zone to
  /// stop unnecessary app crash.
  runZonedGuarded(() {
    ///  this ensures that the Flutter engine is properly initialized
    ///  if application logic needs to interact with
    ///  the native platform (e.g., accessing device features)
    ///  even before building the UI, initializing the
    ///  engine early , then this is crucial.
    WidgetsFlutterBinding.ensureInitialized();

    /// setting the dependencies
    configureDependencies();
    runApp(const UpTodo());
  }, (error, StackTrace stack) {
    debugPrint('Caught error: $error');
    debugPrint('Stack trace: $stack');
  });
}

/// added the App Widget for the Project
class UpTodo extends StatelessWidget {
  /// constructor is getting only key as parameter
  const UpTodo({super.key});

  List<LocalizationsDelegate<dynamic>> get _localizationsDelegates => const [
        /// Built-in localization for text direction LTR/RTL
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,

        /// Your custom delegate for app-specific localization
        AppLocalizations.delegate, // Add this line
      ];

  Locale? _localeResolutionCallback(Locale? locale,
      Iterable<Locale> supportedLocales,) {
    /// Check if the current device locale is supported
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }

    /// If the device's locale is not supported, use
    /// the first one from the list (default)
    return supportedLocales.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SessionBloc>(),
      child: BlocBuilder<SessionBloc, SessionState>(
        buildWhen: (previous, current) => current is LocalChangedState,
        builder: (context, state) {
          final locale = state.maybeWhen(
            localChanged: (local) => local,
            orElse: () => LocaleConstants.defaultLocale,
          );
          return MaterialApp.router(
            routerConfig: getIt<GoRouter>(),
            title: 'UpTodo',
            debugShowCheckedModeBanner: false,

            /// Define the default locale. This will be used if
            /// the system's locale is not supported.
            locale: locale,

            /// Define supported locales
            supportedLocales: LocaleConstants.supportedLocales,
            localizationsDelegates: _localizationsDelegates,

            /// Returns a locale which will be used if the
            /// system's locale is not supported.
            localeResolutionCallback: _localeResolutionCallback,
            builder: _builder,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }

  // TODO(Subhojit): need to revisit (for re-design)
  /// adding conditions later for the feedback package
  /// for error handling
  Widget _builder(BuildContext context, Widget? widget) {
    if (widget == null) throw StateError('widget is null');

    ErrorWidget.builder = (errorDetails) {
      final error = Text(
        '...rendering error...',
        style: Theme.of(context).textTheme.bodyLarge,
      );

      return widget is Scaffold || widget is Navigator
          ? Scaffold(body: Center(child: error))
          : error;
    };

    return widget;
  }
}
