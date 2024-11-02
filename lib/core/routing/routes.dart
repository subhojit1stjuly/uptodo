// Method to define the GoRouter instance
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/home_page/index_screen/home_page.dart';
import 'package:uptodo/features/login_screen/login_page.dart';
import 'package:uptodo/features/splash_screen/splash_page.dart';

/// this is the routing configuration class
class AppRouter {
  /// creating a singleton for this class
  factory AppRouter() => _instance;

  AppRouter._();

  static final AppRouter _instance = AppRouter._();
  final _config = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: <RouteBase>[
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteConstants.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteConstants.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
  /// this is the final variable will be used in the Main.dart file in the
  /// routerConfig parameter
  GoRouter get config => _config;
}

/*GoRouter router(BuildContext context) {

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    //refreshListenable: authStateNotifier,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
   */ /* redirect: (context, state) {
      final authState = authenticationBloc.state;

      if (authState is AuthAuthenticatedState) {
        return state.matchedLocation == '/home' ? null : '/home';
      } else if (authState is AuthUnauthenticatedState ||
          authState is AuthInitialState) {
        return state.matchedLocation == '/login' ? null : '/login';
      }

      return null; // No redirection if conditions are met
    },*/ /*
  );
}*/
