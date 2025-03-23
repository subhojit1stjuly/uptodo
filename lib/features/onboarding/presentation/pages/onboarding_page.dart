import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding/presentation/bloc/state/onboarding_state.dart';
import 'package:uptodo/features/onboarding/presentation/widget/onboarding_widget.dart';
import 'package:uptodo/features/onboarding/presentation/widget/welcome_widget.dart';

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
    final bloc = context.read<OnboardingBloc>();
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (_, curr) => curr is WelComeState || curr is OnboardState,
      bloc: bloc,
      builder: (context, state) {
        return state.maybeWhen(
          welcome: () => const WelcomeWidget(),
          onboard: (List<SvgPicture> data) => OnboardingWidget(
            bloc: bloc,
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
