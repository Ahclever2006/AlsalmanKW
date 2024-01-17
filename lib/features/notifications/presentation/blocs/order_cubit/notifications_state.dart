part of 'notifications_cubit.dart';

enum NotificationsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension NotificationsStateX on NotificationsState {
  bool get isInitial => status == NotificationsStateStatus.initial;
  bool get isLoading => status == NotificationsStateStatus.loading;
  bool get isLoaded => status == NotificationsStateStatus.loaded;
  bool get isLoadingMore => status == NotificationsStateStatus.loadingMore;
  bool get isError => status == NotificationsStateStatus.error;
}

@immutable
class NotificationsState {
  final NotificationModel? notifications;
  final NotificationsStateStatus status;
  final String? errorMessage;

  const NotificationsState({
    this.notifications,
    this.status = NotificationsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as NotificationsState).notifications == notifications &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      notifications.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  NotificationsState copyWith({
    NotificationsStateStatus? status,
    NotificationModel? notifications,
    String? errorMessage,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
