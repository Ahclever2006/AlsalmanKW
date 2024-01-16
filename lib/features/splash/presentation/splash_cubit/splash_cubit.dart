import 'dart:developer';

import '../../../../core/abstract/base_cubit.dart';
import '../../../../core/data/datasources/notification_data_source.dart';
import '../../../../core/exceptions/redundant_request_exception.dart';
import '../../../../core/service/dynamic_link_service.dart';
import '../../data/repositories/splash_repository_impl.dart';

part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit(
    this._notificationDataSource,
    this._dynamicLinkService,
    this._splashRepository,
  ) : super(const SplashState());

  final NotificationDataSource _notificationDataSource;
  final DynamicLinkService _dynamicLinkService;
  final SplashRepository _splashRepository;

  Future<void> init(
    Future<void> Function() initAuth,
    Future<void> Function() initCart,
    String languageCode,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: SplashStateStatus.loading));
      _splashRepository.setInitLanguageIfNotSet(languageCode);
      final isFirstLunch = await _splashRepository.getIsFirstLunch();

      await initAuth();
      await initCart();
      await _notificationDataSource.initNotification();

      await _dynamicLinkService.initDynamicLink(true);
      emit(state.copyWith(
          status: SplashStateStatus.loaded, isFirstLunch: isFirstLunch));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: SplashStateStatus.error, errorMessage: e.toString()));
    }
  }
}
