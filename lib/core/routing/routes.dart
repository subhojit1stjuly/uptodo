// Method to define the GoRouter instance
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/common/bloc/auth_bloc.dart';
import 'package:uptodo/common/bloc/state/auth_state.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/home_page/index_screen/home_page.dart';
import 'package:uptodo/features/login_screen/login_page.dart';
import 'package:uptodo/features/onboarding_screen/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding_screen/onboarding_page.dart';
import 'package:uptodo/features/splash_screen/splash_page.dart';
import 'package:uptodo/l10n/app_localizations_service.dart';

/// this is the routing configuration class
@module
abstract class AppRouter {
  final _config = GoRouter(
    initialLocation: RouteConstants.onBoarding,
    routes: <RouteBase>[
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteConstants.onBoarding,
        builder: (context, state) {
          final localizations = AppLocalizations.of(context)!;
          return BlocProvider(
            create: (_) => OnboardingBloc(
              localizationsService: AppLocalizationsService(localizations),
            ),
            child: const OnboardingPage(),
          );
        },
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
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;

      if (authState is AuthenticatedState) {
        return RouteConstants.home;
      } else if (authState is UnauthenticatedState) {
        return RouteConstants.login;
      }

      return null; // No redirection if conditions are met
    },
  );

  /// this is the final variable will be used in the Main.dart file in the
  /// routerConfig parameter

  @singleton
  GoRouter get config => _config;
}
