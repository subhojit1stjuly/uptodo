import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/app_localizations.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/auth_event.dart';
import 'package:uptodo/features/authentication/presentation/widgets/dynamic_hyphen_widget.dart';
import 'package:uptodo/shared/widgets/texts/custom_textfield.dart';

/// this is the Register Page
class RegisterPage extends StatefulWidget {
  /// constructor for the widget
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthenticationBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// header
              Text(
                AppLocalizations.of(context)!.register,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 40),

              /// username
              CustomTextField(
                labelText: AppLocalizations.of(context)!.username,
                hintText: AppLocalizations.of(context)!.username_hint,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              /// password
              CustomTextField(
                labelText: AppLocalizations.of(context)!.password,
                hintText: AppLocalizations.of(context)!.password_hint,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true, // This enables password mode
              ),
              const SizedBox(height: 20),

              /// confirm password
              CustomTextField(
                labelText: AppLocalizations.of(context)!.confirm_password,
                hintText: AppLocalizations.of(context)!.confirm_password_hint,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true, // This enables password mode
              ),
              const SizedBox(height: 30),

              /// login button
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.register.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),

              /// or
              const SizedBox(height: 10),
              const DynamicHyphenWidget(),
              const SizedBox(height: 10),

              /// social register buttons google
              OutlinedButton(
                onPressed: () {
                  bloc.add(const AuthEvent.loginWithGoogle());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.google.svg(
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.register_with_apple,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              /// social register buttons apple
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.apple.svg(
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.register_with_apple,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.replace(RouteConstants.login);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.button_login,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
