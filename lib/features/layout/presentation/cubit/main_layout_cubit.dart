import 'package:meta/meta.dart';

import '../../../../core/abstract/base_cubit.dart';

part 'main_layout_state.dart';

class MainLayoutCubit extends BaseCubit<MainLayoutState> {
  MainLayoutCubit() : super(const MainLayoutState());

  onBottomNavPressed(int newIndex) {
    emit(state.copyWith(status: MainLayoutStateStatus.loading));
    emit(state.copyWith(
        currentIndex: newIndex,
        status: MainLayoutStateStatus.navBarIndexChanged));
  }
}
