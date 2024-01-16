part of 'j_carousal_products_cubit.dart';

enum JCarousalProductsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension JCarousalProductsStateX on JCarousalProductsState {
  bool get isInitial => status == JCarousalProductsStateStatus.initial;
  bool get isLoading => status == JCarousalProductsStateStatus.loading;
  bool get isLoaded => status == JCarousalProductsStateStatus.loaded;
  bool get isLoadingMore => status == JCarousalProductsStateStatus.loadingMore;
  bool get isError => status == JCarousalProductsStateStatus.error;
}

@immutable
class JCarousalProductsState {
  final JCarouselsModel? carousalSection;
  final JCarousalProductsStateStatus status;
  final String? errorMessage;

  const JCarousalProductsState({
    this.carousalSection,
    this.status = JCarousalProductsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as JCarousalProductsState).carousalSection == carousalSection &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      carousalSection.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  JCarousalProductsState copyWith({
    JCarouselsModel? carousalSection,
    JCarousalProductsStateStatus? status,
    String? errorMessage,
  }) {
    return JCarousalProductsState(
      carousalSection: carousalSection ?? this.carousalSection,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
