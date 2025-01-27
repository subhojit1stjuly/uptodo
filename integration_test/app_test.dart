import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:uptodo/main.dart' as app;

//patrol develop --target integration_test/app_test.dart
void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      // Start the app
      await app.main();

      // Wait for the app to settle
      await $.pumpAndSettle();

      // Example test: Verify the app title
      expect(find.text('UpTodo'), findsOneWidget);

      // Add more Patrol tests here
      if (!Platform.isMacOS) {
        await $.native.pressHome();
      }
    },
  );
}
