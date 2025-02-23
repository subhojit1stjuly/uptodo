import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/routing/route_constants.dart';
import 'package:uptodo/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/auth_event.dart';
import 'package:uptodo/features/authentication/presentation/widgets/dynamic_hyphen_widget.dart';
import 'package:uptodo/shared/widgets/texts/custom_textfield.dart';

/// LoginPage is the page where the user will login
class LoginPage extends StatefulWidget {
  /// const constructor for LoginPage
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// header
              Text(
                AppLocalizations.of(context)!.button_login,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 40),

              /// username
              CustomTextField(
                controller: _emailController,
                labelText: AppLocalizations.of(context)!.username,
                hintText: AppLocalizations.of(context)!.username_hint,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              /// password
              CustomTextField(
                controller: _passwordController,
                labelText: AppLocalizations.of(context)!.password,
                hintText: AppLocalizations.of(context)!.password_hint,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true, // This enables password mode
              ),
              const SizedBox(height: 50),

              /// login button
              ElevatedButton(
                onPressed: () {
                  bloc.add(
                    AuthEvent.loginWithEmail(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.button_login.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),

              /// or
              const SizedBox(height: 10),
              const DynamicHyphenWidget(),
              const SizedBox(height: 10),

              /// social login buttons google
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
                      AppLocalizations.of(context)!.login_with_google,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              /// social login buttons apple
              OutlinedButton(
                onPressed: () {
                  bloc.add(const AuthEvent.loginWithPhone());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.apple.svg(
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.login_with_apple,
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
                    AppLocalizations.of(context)!.dont_have_account,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.replace(RouteConstants.register);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.register,
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
