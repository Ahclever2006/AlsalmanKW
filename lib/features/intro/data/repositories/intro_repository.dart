import '../../../../core/data/models/banner_model.dart';

import '../datasources/intro_local_data_source.dart';
import '../datasources/intro_remote_data.dart';

abstract class IntroRepository {
  Future<HomeBannerModel> getIntroBanners();
  Future<void> setIsFirstLunch();
}

class IntroRepositoryImpl implements IntroRepository {
  final IntroRemoteDataSource _introRemoteDataSource;
  final IntroLocalDataSource _introLocalDataSource;
  IntroRepositoryImpl(this._introRemoteDataSource, this._introLocalDataSource);

  @override
  Future<HomeBannerModel> getIntroBanners() =>
      _introRemoteDataSource.getIntroBanners();

  @override
  Future<void> setIsFirstLunch() => _introLocalDataSource.setIsFirstLunch();
}
