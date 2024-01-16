import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../api_end_point.dart';
import '../../../../core/abstract/base_cubit.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/exceptions/redundant_request_exception.dart';
import '../../../../core/service/launcher_service.dart';
import '../../../../main.dart';
import '../../../../res/style/theme.dart';
import '../../data/repositories/intro_repository.dart';

part 'intro_state.dart';

class IntroCubit extends BaseCubit<IntroState> {
  IntroCubit(this._introRepository, this._launcherService)
      : super(const IntroState());

  final IntroRepository _introRepository;
  final LauncherService _launcherService;
  Future<void> openLink(String link) async {
    await _launcherService.openWebsite(link);
  }

  void autoChangedCarouselIndex(int index) {
    emit(state.copyWith(
        status: IntroStateStatus.loaded, introBannerIndex: index));
  }

  Future<void> loadIntroData([bool refresh = false]) async {
    try {
      if (!refresh) {
        emit(state.copyWith(status: IntroStateStatus.loading));
      }
      final banners = await _introRepository.getIntroBanners();

      if (banners.data != null)
        banners.data!.forEach((model) async {
          await precacheImage(
              CachedNetworkImageProvider(
                  '${ApiEndPoint.domainUrl}/${model.fileUrl}'),
              navigatorKey.currentContext!);
        });

      emit(state.copyWith(
        status: IntroStateStatus.loaded,
        introBanners: banners,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: IntroStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> setIsFirstLunch() async {
    try {
      await _introRepository.setIsFirstLunch();
    } catch (e) {
      emit(state.copyWith(
          status: IntroStateStatus.error, errorMessage: e.toString()));
    }
  }
}
