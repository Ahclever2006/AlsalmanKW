import '../datasources/account_remote_data_source.dart';

abstract class AccountRepository {}

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource _accountRemoteDataSource;
  AccountRepositoryImpl(this._accountRemoteDataSource);

  // @override
  // Future<HomeBannerModel> getHomeBanners() =>
  //     _homeRemoteDataSource.getHomeBanners();
}
