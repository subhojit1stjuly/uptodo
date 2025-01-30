// Method to define the GoRouter instance
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/authentication/presentation/bloc/session_bloc.dart';
import 'package:uptodo/features/authentication/presentation/bloc/state/session_state.dart';
import 'package:uptodo/features/authentication/presentation/pages/login_page.dart';
import 'package:uptodo/features/authentication/presentation/pages/register_page.dart';
import 'package:uptodo/features/home/index_screen/home_page.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:uptodo/features/onboarding/presentation/pages/permission_page.dart';
import 'package:uptodo/features/settings/presentation/pages/change_language_page.dart';
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
      switch (session.runtimeType) {
        case SessionLoadingState _:
          return null; // No redirection if conditions are met
        case SessionValidState _:
          return RouteConstants.home;
        case SessionInvalidState _:
          return RouteConstants.login;
        default:
          return null; // No redirection if conditions are met
      }
    },
  );

  /// this is the final variable will be used in the Main.dart file in the
  /// routerConfig parameter

  @singleton
  GoRouter get config => _config;
}
