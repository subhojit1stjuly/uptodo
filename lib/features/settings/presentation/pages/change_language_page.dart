import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/localizations/app_localizations.dart';
import 'package:uptodo/core/localizations/app_localizations_service.dart';
import 'package:uptodo/features/authentication/presentation/bloc/event/user_session_event.dart';
import 'package:uptodo/features/authentication/presentation/bloc/user_session_bloc.dart';

/// screen for the changing the language
class ChangeLanguagePage extends StatefulWidget {
  /// constructor for the widget
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Language',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListTileTheme(
        data: Theme.of(context).listTileTheme,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final locale = AppLocalizations.supportedLocales[index];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  AppLocalizationsService(AppLocalizations.of(context)!)
                      .getLocaleName(locale),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: Radio(
                  value: locale,
                  groupValue: AppLocalizations.of(context),
                  onChanged: (value) {
                    context.read<UserSessionBloc>().add(
                          UserSessionEvent.localChanges(
                            local: locale,
                          ),
                        );
                    context.pop();
                  },
                ),
              ),
            );
          },
          itemCount: AppLocalizations.supportedLocales.length,
        ),
      ),
    );
  }
}
