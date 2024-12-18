import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uptodo/core/theme/dark_theme.dart';
import 'package:uptodo/core/theme/light_theme.dart';
import 'package:uptodo/presentation/splash/splash_page.dart';

void main() {
  testWidgets('SplashPage displays logo', (WidgetTester tester) async {
    await tester.pumpWidget(
        testingApp(),
    );

    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('SplashPage displays app name', (WidgetTester tester) async {
    await tester.pumpWidget(
      testingApp(),
    );

    expect(find.text('UpTodo'), findsOneWidget);
  });

  testWidgets('SplashPage background color in light mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      testingApp(),
    );

    final coloredBox = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(coloredBox.color, Colors.white);
  });

  testWidgets('SplashPage background color in dark mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      testingApp(themeMode: ThemeMode.dark),
    );

    final coloredBox = tester.widget<ColoredBox>(find.byType(ColoredBox));
    expect(coloredBox.color, Colors.black87);
  });

  testWidgets('SplashPage layout on larger devices',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      testingApp(),
    );

    // Simulate a larger device by setting a larger screen size
    tester.view.physicalSize = const Size(1440, 2560);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpAndSettle();

    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets('SplashPage displays logo and app name centered',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      testingApp(),
    );

    // Verify if the logo is displayed
    final logoFinder = find.byType(SvgPicture);
    expect(logoFinder, findsOneWidget);

    // Verify if the app name is displayed
    final appNameFinder = find.text('UpTodo');
    expect(appNameFinder, findsOneWidget);

    // Verify if the logo and app name are centered together
    final logoCenter = tester.getCenter(logoFinder);
    final appNameCenter = tester.getCenter(appNameFinder);

    // Check if the logo and app name are vertically aligned
    expect(logoCenter.dy, lessThan(appNameCenter.dy));
    expect((appNameCenter.dy - logoCenter.dy).abs(), greaterThan(0));
  });
}
MaterialApp testingApp({ThemeMode themeMode = ThemeMode.light}){
  return MaterialApp(
    locale: const Locale('en', 'US'),

    /// Define supported locales
    supportedLocales: const [
      Locale('en', 'US'), // English
      Locale('bn', 'IN'), // Bengali
      Locale('kn', 'IN'), // Kannada
      Locale('hi', 'IN'), // Hindi
      /// Add more locales here
    ],
    localizationsDelegates: const [
      /// Built-in localization for text direction LTR/RTL
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,

      /// Your custom delegate for app-specific localization
      AppLocalizations.delegate, // Add this line
    ],
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: themeMode,
    home: const SplashPage(),
  );
}
