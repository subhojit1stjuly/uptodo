flutter pub clean
flutter pub get
dart pub global run full_coverage
flutter test --coverage
genhtml coverage/new_lcov.info --output=coverage
open coverage/index.html