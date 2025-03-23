import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constants/assets.gen.dart';
import 'package:uptodo/core/di/injector.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/event/home_event.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/home_bloc.dart';
import 'package:uptodo/features/home/presentation/index_screen/bloc/state/home_state.dart';
import 'package:uptodo/features/home/presentation/index_screen/widget/custom_bottom_nav.dart';
import 'package:uptodo/features/home/presentation/index_screen/widget/loading_widget.dart';
import 'package:uptodo/features/task_details/presentation/bloc/task_bloc.dart';
import 'package:uptodo/features/task_details/presentation/widget/task_creation_bottom_sheet.dart';

/// Home page
class HomePage extends StatelessWidget {
  /// Constructor for HomePage
  const HomePage({
    required this.navigationShell,
    super.key,
  });

  /// Navigation shell
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>(),
      listenWhen: (_, cur) => cur is OpenTaskDialogState,
      listener: (_, curr) {
        if (curr is OpenTaskDialogState) {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) => BlocProvider(
              create: (context) => getIt<TaskBloc>(),
              child: const TaskCreationBottomSheet(),
            ),
          );
        }
      },
      buildWhen: (_, cur) => cur is NavigationChangeState,
      builder: (context, state) {
        if (state is initiaHomeState) {
          return const LoadingWidget();
        } else if (state is ErrorState) {
          return ErrorWidget.withDetails(message: state.message);
        } else if (state is NavigationChangeState) {
          return Scaffold(
            appBar: _buildAppBar(
              context,
              context.read<HomeBloc>(),
              state.index,
            ),
            bottomNavigationBar: _buildNavigationBar(context, state),
            body: navigationShell,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    HomeBloc bloc,
    int index,
  ) {
    return AppBar(
      leading: Assets.icons.dash.svg(height: 24, width: 24),
      centerTitle: true,
      title: Text(
        bloc.navigationItems[index].title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => context.read<HomeBloc>().add(
                const HomeEvent.logout(),
              ),
        ),
      ],
    );
  }

  Widget _buildNavigationBar(
    BuildContext context,
    NavigationChangeState state,
  ) {
    return CustomBottomNavBar(
      selectedIndex: state.index,
      onTap: (index) {
        context.read<HomeBloc>().add(HomeEvent.setIndex(index));
      },
    );
  }
}
