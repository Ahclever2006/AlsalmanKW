import '../../service/notification_service.dart';

abstract class NotificationDataSource {
  Future<void> initNotification();
  Future<String?> getNotificationMobileAppId();
  Future<void> cancelNotification();
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final NotificationService _notificationService;

  NotificationDataSourceImpl(this._notificationService);

  @override
  Future<void> cancelNotification() => _notificationService.cancelAll();

  @override
  Future<String?> getNotificationMobileAppId() =>
      _notificationService.getDeviceTokenId();

  @override
  Future<void> initNotification() => _notificationService.inti();
}
