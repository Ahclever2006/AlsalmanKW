part of 'topics_cubit.dart';

enum TopicsStateStatus { initial, loading, loaded, error }

extension TopicsStateX on TopicsState {
  bool get isInitial => status == TopicsStateStatus.initial;
  bool get isLoading => status == TopicsStateStatus.loading;
  bool get isLoaded => status == TopicsStateStatus.loaded;
  bool get isError => status == TopicsStateStatus.error;
}

class TopicsState {
  final Topic? topicContent;
  final TopicsStateStatus status;
  final String? errorMessage;

  const TopicsState({
    this.topicContent,
    this.status = TopicsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as TopicsState).topicContent == topicContent &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      topicContent.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  TopicsState copyWith({
    TopicsStateStatus? status,
    Topic? topicContent,
    String? errorMessage,
  }) {
    return TopicsState(
      status: status ?? this.status,
      topicContent: topicContent ?? this.topicContent,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
