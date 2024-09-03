dart run build_runner build --delete-conflicting-outputs --build-filter="test/**" # added for the mock generation
dart pub global run full_coverage
flutter test --coverage
genhtml coverage/new_lcov.info --output=coverage
open coverage/index.html