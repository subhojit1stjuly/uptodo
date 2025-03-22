// Method to define the GoRouter instance
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uptodo/features/authentication/presentation/bloc/user_session_bloc.dart';
import 'package:uptodo/features/authentication/presentation/pages/login_page.dart';
import 'package:uptodo/features/authentication/presentation/pages/register_page.dart';
import 'package:uptodo/features/home/calendar_screen/presentation/page/calendar_page.dart';
import 'package:uptodo/features/home/focus_screen/presentation/page/focus_page.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/home_bloc.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/index_bloc.dart';
import 'package:uptodo/features/home/index_screen/presentation/bloc/state/home_state.dart';
import 'package:uptodo/features/home/index_screen/presentation/page/home_page.dart';
import 'package:uptodo/features/home/index_screen/presentation/page/index_page.dart';
import 'package:uptodo/features/home/profile_screen/presentation/page/profile_page.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:uptodo/features/settings/presentation/pages/change_language_page.dart';
import 'package:uptodo/features/splash/splash_page.dart';

/// this is the routing configuration class
@module
abstract class AppRouter {
  /// this is the final variable will be used in the Main.dart file in the
  /// routerConfig parameter
  @singleton
  GoRouter get config => GoRouter(
        initialLocation: RouteConstants.splash,
        routes: <RouteBase>[
          GoRoute(
            name: RouteConstants.splash,
            path: RouteConstants.splash,
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            name: RouteConstants.onBoarding,
            path: RouteConstants.onBoarding,
            builder: (context, state) {
              return BlocProvider(
                create: (_) => OnboardingBloc(),
                child: const OnboardingPage(),
              );
            },
          ),
          GoRoute(
            name: RouteConstants.login,
            path: RouteConstants.login,
            builder: (context, state) => BlocProvider.value(
              value: getIt<AuthenticationBloc>(),
              child: const LoginPage(),
            ),
          ),
          GoRoute(
            name: RouteConstants.register,
            path: RouteConstants.register,
            builder: (context, state) => BlocProvider.value(
              value: getIt<AuthenticationBloc>(),
              child: const RegisterPage(),
            ),
          ),
          ShellRoute(
            builder: (context, state, child) => BlocProvider.value(
              value: getIt<HomeBloc>(),
              child: HomePage(
                child: child,
              ),
            ),
            routes: [
              GoRoute(
                name: RouteConstants.index,
                path: RouteConstants.home,
                builder: (context, state) => BlocProvider.value(
                  value: getIt<IndexBloc>(),
                  child: const IndexPage(),
                ),
              ),
              GoRoute(
                name: RouteConstants.calendar,
                path: RouteConstants.calendar,
                builder: (context, state) => const CalendarPage(),
              ),
              GoRoute(
                name: RouteConstants.focus,
                path: RouteConstants.focus,
                builder: (context, state) => const FocusPage(),
              ),
              GoRoute(
                name: RouteConstants.profile,
                path: RouteConstants.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
            redirect: (context, state) {
              final state = getIt<HomeBloc>().state;
              if (state is NavigationChangeState) {
                /// Handle navigation between tabs
                return RouteConstants.homeNavigation[state.index];
              } else if (state is LogoutState) {
                return RouteConstants.login;
              }
              return null;
            },
          ),
          GoRoute(
            name: RouteConstants.changeLanguage,
            path: RouteConstants.changeLanguage,
            builder: (context, state) => const ChangeLanguagePage(),
          ),
        ],
        redirect: (context, state) {
          final sessionState = context.read<UserSessionBloc>().state;
          if (state.matchedLocation != RouteConstants.splash) {
            return null;
          }
          return sessionState.maybeWhen(
            sessionValid: () => RouteConstants.home,
            sessionInvalid: (hasSeenOnboarding) => hasSeenOnboarding
                ? RouteConstants.login
                : RouteConstants.onBoarding,
            orElse: () {
              return null;
            },
          );
        },
        // TODO(Subhojit): add error Page builder and error builder
      );
}
