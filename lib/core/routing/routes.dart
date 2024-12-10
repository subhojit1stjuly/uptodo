// Method to define the GoRouter instance
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/common/bloc/session_bloc.dart';
import 'package:uptodo/common/bloc/state/session_state.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/authentication/login_page.dart';
import 'package:uptodo/features/authentication/register_page.dart';
import 'package:uptodo/features/home/index_screen/home_page.dart';
import 'package:uptodo/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding/onboarding_page.dart';
import 'package:uptodo/features/onboarding/permission_page.dart';
import 'package:uptodo/features/settings/change_language_page.dart';
import 'package:uptodo/features/splash/splash_page.dart';
import 'package:uptodo/l10n/app_localizations_service.dart';

/// this is the routing configuration class
@module
abstract class AppRouter {
  final _config = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: <RouteBase>[
      GoRoute(
        path: RouteConstants.splash,
        builder: (context, state) => const SplashPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return child;
        },
        routes: [
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
            path: RouteConstants.register,
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: RouteConstants.permissions,
            builder: (context, state) => const PermissionPage(),
          ),
        ],
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
      GoRoute(
        path: RouteConstants.changeLanguage,
        builder: (context, state) => const ChangeLanguagePage(),
      ),
    ],
    redirect: (context, state) {
      final session = context.read<SessionBloc>().state;
      if (session is SessionValidState) {
        return RouteConstants.home;
      } else if (session is SessionInvalidState) {
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
