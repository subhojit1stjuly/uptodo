import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/config/firebase_config.dart';
import 'package:uptodo/core/di/injector.config.dart';
import 'package:uptodo/core/storage/objectbox/objectbox.dart';

/// singleton for get_it
final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

/// generated dependencies using injectables
Future<void> configureDependencies() async {
  getIt.init();
  await getIt<ObjectBox>().init();
  await Firebase.initializeApp(
    options: kIsWeb ? FirebaseConfig.web : FirebaseConfig.currentPlatform,
  );
}
