import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:uptodo/features/home/index_screen/domain/usecases/get_navigation_items.dart';
import 'package:uptodo/features/home/index_screen/domain/usecases/handle_logout.dart';
import 'package:uptodo/features/home/index_screen/presentation/cubit/navigation_state.dart';

/// NavigationCubit class
@singleton
class NavigationCubit extends Cubit<NavigationState> {
  /// constructor
  NavigationCubit(
    this._getNavigationItems,
    this._handleLogout,
    this._router,
  ) : super(const NavigationState(selectedIndex: 0, items: [])) {
    _loadNavigationItems();
  }

  final GoRouter _router;
  final GetNavigationItems _getNavigationItems;
  final HandleLogout _handleLogout;

  Future<void> _loadNavigationItems() async {
    emit(
      NavigationState(
        selectedIndex: state.selectedIndex,
        items: const [],
        isLoading: true,
      ),
    );

    final result = await _getNavigationItems.execute(null);
    emit(
      NavigationState(
        selectedIndex: state.selectedIndex,
        items: result,
      ),
    );
  }

  /// setIndex method
  void setIndex(int index) {
    emit(
      NavigationState(
        selectedIndex: index,
        items: state.items,
      ),
    );
    _router.refresh();
  }

  /// logout method
  Future<void> logout() async {
    final result = await _handleLogout.execute(null);
    if (result) {
      emit(
        NavigationState(
          selectedIndex: 0,
          items: state.items,
        ),
      );
    }
  }
}
