part of 'main_layout_cubit.dart';

enum MainLayoutStateStatus { initial, loading, navBarIndexChanged, error }

extension MainLayoutStateX on MainLayoutState {
  bool get isInitial => status == MainLayoutStateStatus.initial;
  bool get isLoading => status == MainLayoutStateStatus.loading;
  bool get isNavBarIndexChanged =>
      status == MainLayoutStateStatus.navBarIndexChanged;

  bool get isError => status == MainLayoutStateStatus.error;
}

@immutable
class MainLayoutState {
  final int? currentIndex;
  final MainLayoutStateStatus status;
  final String? errorMessage;
  const MainLayoutState({
    this.currentIndex = 0,
    this.status = MainLayoutStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as MainLayoutState).currentIndex == currentIndex &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      currentIndex.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  MainLayoutState copyWith({
    MainLayoutStateStatus? status,
    int? currentIndex,
    String? errorMessage,
  }) {
    return MainLayoutState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
