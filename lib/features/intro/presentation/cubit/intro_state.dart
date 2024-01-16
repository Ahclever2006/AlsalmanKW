part of 'intro_cubit.dart';

enum IntroStateStatus { initial, loading, loaded, error }

extension IntroStateX on IntroState {
  bool get isInitial => status == IntroStateStatus.initial;
  bool get isLoading => status == IntroStateStatus.loading;
  bool get isLoaded => status == IntroStateStatus.loaded;
  bool get isError => status == IntroStateStatus.error;
}

@immutable
class IntroState {
  final IntroStateStatus status;
  final HomeBannerModel? introBanners;
  final int? introBannerIndex;
  final String? errorMessage;
  const IntroState({
    this.status = IntroStateStatus.initial,
    this.introBanners,
    this.introBannerIndex = 0,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as IntroState).status == status &&
        other.introBanners == introBanners &&
        other.introBannerIndex == introBannerIndex &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      introBanners.hashCode ^
      introBannerIndex.hashCode ^
      errorMessage.hashCode;

  IntroState copyWith({
    IntroStateStatus? status,
    HomeBannerModel? introBanners,
    int? introBannerIndex,
    String? errorMessage,
  }) {
    return IntroState(
      status: status ?? this.status,
      introBanners: introBanners ?? this.introBanners,
      introBannerIndex: introBannerIndex ?? this.introBannerIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
