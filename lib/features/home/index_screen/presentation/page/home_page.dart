import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/features/home/index_screen/presentation/cubit/navigation_cubit.dart';
import 'package:uptodo/features/home/index_screen/presentation/cubit/navigation_state.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/custom_bottom_nav.dart';
import 'package:uptodo/features/home/index_screen/presentation/widget/loading_widget.dart';

/// Home page
class HomePage extends StatelessWidget {
  /// Constructor for HomePage
  const HomePage({
    required this.child,
    super.key,
  });

  /// Child widget to display in the body
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      bloc: context.read<NavigationCubit>(),
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingWidget();
        }

        if (state.error != null) {
          return ErrorWidget.withDetails(message: state.error!);
        }

        return Scaffold(
          appBar: _buildAppBar(context, state),
          bottomNavigationBar: _buildNavigationBar(context, state),
          body: SafeArea(child: child),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    NavigationState state,
  ) {
    return AppBar(
      leading: Assets.icons.dash.svg(height: 24, width: 24),
      centerTitle: true,
      title: Text(
        state.items[state.selectedIndex].title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => context.read<NavigationCubit>().logout(),
        ),
      ],
    );
  }

  Widget _buildNavigationBar(BuildContext context, NavigationState state) {
    return CustomBottomNavBar(
      selectedIndex: state.selectedIndex,
      onTap: (index) {
        context.read<NavigationCubit>().setIndex(index);
      },
    );
  }
}
