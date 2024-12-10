import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uptodo/features/onboarding/bloc/event/onboarding_event.dart';
import 'package:uptodo/features/onboarding/bloc/onboard_model.dart';
import 'package:uptodo/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:uptodo/features/onboarding/bloc/state/onboarding_state.dart';

/// this Widget represent the Onboarding Page
class OnboardingWidget extends StatefulWidget {
  /// this the Constructor which accepts the page index and list of data
  const OnboardingWidget({
    required this.data,
    required this.bloc,
    super.key,
  });

  /// this object holds the data
  final List<OnboardModel> data;

  /// bloc for the ui
  final OnboardingBloc bloc;

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(const OnboardingEvent.initialize());
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                skipAndLanguageWidget(context),

                /// pageView
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (pageNo) {
                      widget.bloc.add(
                        OnboardingEvent.change(pageNo),
                      );
                    },
                    controller: _controller,
                    itemCount: widget.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.data[index].image;
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                /// dots
                Align(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: widget.data.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 4,
                      // Factor for expanding dots
                      dotWidth: 10,
                      // Default size of the dots
                      dotHeight: 10,
                      radius: 5,
                      // Corner radius for the dot
                      dotColor: Colors.white,
                      // Inactive dots color
                      activeDotColor: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                titleAndDescriptionWidget(context),

                nextAndBackWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// handles the Skip and Language Change buttons
  Widget skipAndLanguageWidget(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              widget.bloc.add(const OnboardingEvent.skip());
            },
            child: Text(
              AppLocalizations.of(context)!.button_skip.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Icon(Icons.translate_rounded),
          ),
        ],
      ),
    );
  }

  /// handles the ui for Next and Back Button with Get-Started
  Widget nextAndBackWidget(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              widget.bloc.add(const OnboardingEvent.previous());
              _controller.previousPage(
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.decelerate,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.button_back.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.bloc.add(const OnboardingEvent.next());
              _controller.nextPage(
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.decelerate,
              );
            },
            child: Text(
              /*_controller.page!.toInt() == 2
                  ? AppLocalizations.of(context)!
                      .button_get_started
                      .toUpperCase()
                  : */
              AppLocalizations.of(context)!.button_next.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// shows the title and description
  Widget titleAndDescriptionWidget(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        bloc: widget.bloc,
        buildWhen: (_, curr) => curr is ChangeState,
        builder: (context, state) {
          return state.maybeWhen(
            change: (pageNo) => Column(
              children: [
                Text(
                  widget.data[pageNo].title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.data[pageNo].desc,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            orElse: () {
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
