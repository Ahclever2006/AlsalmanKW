import 'dart:developer';

import 'package:meta/meta.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/notification_model.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/repositories/order_repository_impl.dart';

part 'notifications_state.dart';

class NotificationsCubit extends BaseCubit<NotificationsState> {
  final NotificationsRepository _notificationsRepository;

  NotificationsCubit(
    this._notificationsRepository,
  ) : super(const NotificationsState());

  Future<void> getNotifications() async {
    emit(state.copyWith(status: NotificationsStateStatus.loading));
    try {
      final notifications = await _notificationsRepository.getNotifications();
      emit(state.copyWith(
        status: NotificationsStateStatus.loaded,
        notifications: notifications,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: NotificationsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getMoreNotifications({
    int sort = 0,
    int pageSize = 10,
  }) async {
    var oldCurrentOrders = state.notifications!.data;
    int pageNumber = ((oldCurrentOrders!.length / 10).floor() + 1);
    if (oldCurrentOrders.length % 10 != 0) return;
    try {
      emit(state.copyWith(status: NotificationsStateStatus.loadingMore));

      final newCurrentOrders = await _notificationsRepository.getNotifications(
        pageSize: pageSize,
        pageNumber: pageNumber,
      );

      emit(
        state.copyWith(
            status: NotificationsStateStatus.loaded,
            notifications: state.notifications!.copyWith(
                data: [...oldCurrentOrders, ...?newCurrentOrders.data])),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: NotificationsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => getNotifications();
}
