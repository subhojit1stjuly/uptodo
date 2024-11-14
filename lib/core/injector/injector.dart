import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/injector/injector.config.dart';

/// singleton for get_it
final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
/// generated dependencies using injectables
void configureDependencies() => getIt.init();
