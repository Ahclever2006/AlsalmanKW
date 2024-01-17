import '../../../../core/data/models/notification_model.dart';
import '../datasources/notifications_remote_data_source.dart';

abstract class NotificationsRepository {
  Future<NotificationModel> getNotifications({
    int pageNumber = 1,
    int pageSize = 10,
  });
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _notificationsRemoteDataSource;

  const NotificationsRepositoryImpl(this._notificationsRemoteDataSource);

  @override
  Future<NotificationModel> getNotifications({
    int pageNumber = 1,
    int pageSize = 10,
  }) =>
      _notificationsRemoteDataSource.getNotifications(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
}
