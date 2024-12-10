import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/features/onboarding/bloc/onboard_model.dart';
import 'package:uptodo/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding/bloc/state/onboarding_state.dart';
import 'package:uptodo/features/onboarding/widget/onboarding_widget.dart';
import 'package:uptodo/features/onboarding/widget/welcome_widget.dart';

/// this is the onboarding Page
class OnboardingPage extends StatefulWidget {
  /// this the constructor for the Widget
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (_,curr)=> curr is WelComeState || curr is OnboardState,
      bloc: context.read<OnboardingBloc>(),
      builder: (context, state) {
        return state.maybeWhen(
          welcome: () => const WelcomeWidget(),
          onboard: (List<OnboardModel> data) => OnboardingWidget(
            bloc: context.read<OnboardingBloc>(),
            data: data,
          ),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
