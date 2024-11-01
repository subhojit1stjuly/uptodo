// Method to define the GoRouter instance
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/bloc/provider/auth_bloc.dart';
import 'package:uptodo/common/bloc/state/auth_state.dart';
/// this is the routing configuration class
GoRouter router(BuildContext context) {
  final authenticationBloc = context.read<AuthBloc>();
  final authStateNotifier =
      ValueNotifier<AuthState>(context.read<AuthBloc>().state);

  context.read<AuthBloc>().stream.listen((state) {
    authStateNotifier.value = state;
  });
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    refreshListenable: authStateNotifier,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
    ],
    redirect: (context, state) {
      final authState = authenticationBloc.state;

      if (authState is AuthAuthenticated) {
        return state.matchedLocation == '/home' ? null : '/home';
      } else if (authState is AuthUnauthenticated || authState is AuthInitial) {
        return state.matchedLocation == '/login' ? null : '/login';
      }

      return null; // No redirection if conditions are met
    },
  );
}
