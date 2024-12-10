import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uptodo/features/onboarding/bloc/event/onboarding_event.dart';
import 'package:uptodo/features/onboarding/bloc/onboarding_bloc.dart';

/// welcome screen with Login and Register button
class WelcomeWidget extends StatelessWidget {
  /// this is the constructor
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OnboardingBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            bloc.add(
              const OnboardingEvent.back(),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///welcome message
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.welcome_title,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 35,
            ),
            ///welcomes subtitle
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.welcome_desc,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Expanded(
              child: SizedBox(),
            ),

            ///login button
            ElevatedButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.button_login.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ///create account
            OutlinedButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.button_create_account.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
