import 'dart:developer';

import 'package:meta/meta.dart';
import '../../../../core/service/launcher_service.dart';

import '../../../../core/abstract/base_cubit.dart';
import '../../../../core/data/models/banner_model.dart';
import '../../../../core/data/models/home_carousal_collection_model.dart';
import '../../../../core/data/models/home_categ_model.dart';
import '../../../../core/exceptions/redundant_request_exception.dart';
import '../../data/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(this._homeRepository, this._launcherService)
      : super(const HomeState());

  final HomeRepository _homeRepository;
  final LauncherService _launcherService;

  Future<void> loadHomeData([bool refresh = false]) async {
    try {
      if (!refresh) {
        emit(state.copyWith(status: HomeStateStatus.loading));
      }
      final banners = await _homeRepository.getHomeBanners();
      final carouselFirstBanners =
          await _homeRepository.getCarouselFirstBanners();
      final carouselSecondBanners =
          await _homeRepository.getCarouselSecondBanners();
      final carouselThirdBanners =
          await _homeRepository.getCarouselThirdBanners();

      final categoriesBanners = await _homeRepository.getCategoriesBanners();

      emit(state.copyWith(
          status: HomeStateStatus.loaded,
          banners: banners,
          carouselFirstBanners: carouselFirstBanners,
          carouselSecondBanners: carouselSecondBanners,
          carouselThirdBanners: carouselThirdBanners,
          categoriesBanners: categoriesBanners));
      final categories = await _homeRepository.getHomeCategories();
      emit(state.copyWith(
        status: HomeStateStatus.loaded,
        categories: categories,
      ));
      final carousalSections = await _homeRepository.getHomeCarousalSection();

      emit(state.copyWith(
        status: HomeStateStatus.loaded,
        carousalSections: carousalSections,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: HomeStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => loadHomeData(true);

  void autoChangedCarouselIndex(int index) {
    emit(
        state.copyWith(status: HomeStateStatus.loaded, homeBannerIndex: index));
  }

  Future<void> openLink(String link) async {
    await _launcherService.openWebsite(link);
  }
}
