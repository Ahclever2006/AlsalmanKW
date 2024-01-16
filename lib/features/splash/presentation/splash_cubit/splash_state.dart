part of 'splash_cubit.dart';

enum SplashStateStatus { initial, loading, loaded, error }

extension SplashStateX on SplashState {
  bool get isInitial => status == SplashStateStatus.initial;
  bool get isLoading => status == SplashStateStatus.loading;
  bool get isLoaded => status == SplashStateStatus.loaded;
  bool get isError => status == SplashStateStatus.error;
}

class SplashState {
  final SplashStateStatus status;
  final bool? isFirstLunch;
  final bool? isVideoCompleted;
  final String? errorMessage;
  const SplashState({
    this.status = SplashStateStatus.initial,
    this.isFirstLunch = true,
    this.isVideoCompleted = false,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as SplashState).status == status &&
        other.isFirstLunch == isFirstLunch &&
        other.isVideoCompleted == isVideoCompleted &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      isFirstLunch.hashCode ^
      isVideoCompleted.hashCode ^
      errorMessage.hashCode;

  SplashState copyWith({
    SplashStateStatus? status,
    bool? isFirstLunch,
    bool? isVideoCompleted,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      isFirstLunch: isFirstLunch ?? this.isFirstLunch,
      isVideoCompleted: isVideoCompleted ?? this.isVideoCompleted,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
