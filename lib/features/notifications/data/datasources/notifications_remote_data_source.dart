import '../../../../core/data/models/notification_model.dart';

import '/api_end_point.dart';
import '/core/exceptions/request_exception.dart';
import '/core/service/network_service.dart';

abstract class NotificationsRemoteDataSource {
  Future<NotificationModel> getNotifications(
      {int pageNumber = 1, int pageSize = 10});
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final NetworkService _networkService;

  NotificationsRemoteDataSourceImpl(this._networkService);

  @override
  Future<NotificationModel> getNotifications(
      {int pageNumber = 1, int pageSize = 10}) {
    const url = ApiEndPoint.getNotificationsList;
    return _networkService.get(url, queryParameters: {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
      "markAsRead": true
    }).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      final resultStatus = result['IsSuccess'];
      if (resultStatus != null && !resultStatus)
        throw RequestException(result['Errors']);
      return NotificationModel.fromMap(result);
    });
  }
}
