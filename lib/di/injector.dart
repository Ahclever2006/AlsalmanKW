import '../features/intro/data/datasources/intro_local_data_source.dart';
import '../features/intro/data/datasources/intro_remote_data.dart';
import '../features/intro/data/repositories/intro_repository.dart';
import '../features/intro/presentation/cubit/intro_cubit.dart';
import '../features/notifications/data/datasources/notifications_remote_data_source.dart';
import '../features/notifications/data/repositories/order_repository_impl.dart';
import '../features/notifications/presentation/blocs/order_cubit/notifications_cubit.dart';
import '../features/wallet/presentation/blocs/wallet_withdraw_cubit/wallet_withdraw_cubit.dart';

import '../core/data/datasources/device_type_data_source.dart';
import '../core/data/datasources/external_login_data_source.dart';
import '../core/data/datasources/notification_data_source.dart';
import '../core/service/app_info_service.dart';
import '../core/service/cache_service.dart';
import '../core/service/dynamic_link_service.dart';
import '../core/service/launcher_service.dart';
import '../core/service/my_fatoorah_service.dart';
import '../core/service/network_service.dart';
import '../core/service/notification_service.dart';
import '../core/service/share_service.dart';
import '../features/account_tab/presentation/blocs/cubit/account_cubit.dart';
import '../features/account_tab/presentation/blocs/topics_cubit/topics_cubit.dart';
import '../features/address/data/datasources/address_remote_data_source.dart';
import '../features/address/data/repositories/address_repository_impl.dart';
import '../features/address/presentation/blocs/address_cubit/address_cubit.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../features/brand_products/data/datasources/brand_products_list_remote_data_source.dart';
import '../features/brand_products/data/repositories/brand_products_repository_impl.dart';
import '../features/brand_products/presentation/blocs/cubit/brand_products_cubit.dart';
import '../features/brands/data/datasources/brands_remote_data_source.dart';
import '../features/brands/data/repositories/brands_repository_impl.dart';
import '../features/brands/presentation/blocs/cubit/brands_cubit.dart';
import '../features/cart_tab/data/datasources/cart_remote_data_source.dart';
import '../features/cart_tab/data/repositories/cart_repository.dart';
import '../features/cart_tab/presentation/cubit/cart_cubit.dart';
import '../features/categories/data/datasources/categories_remote_data_source.dart';
import '../features/categories/data/repositories/categories_repository_impl.dart';
import '../features/categories/presentation/blocs/cubit/categories_cubit.dart';
import '../features/category_products/data/datasources/category_products_list_remote_data_source.dart';
import '../features/category_products/data/repositories/category_products_repository_impl.dart';
import '../features/category_products/presentation/blocs/cubit/category_products_cubit.dart';
import '../features/check_out/data/datasources/checkout_remote_data_source.dart';
import '../features/check_out/data/repositories/checkout_repository_impl.dart';
import '../features/check_out/presentation/blocs/order_cubit/checkout_cubit.dart';
import '../features/favorites/data/datasources/favorites_remote_data_source.dart';
import '../features/favorites/data/repositories/favorites_repository.dart';
import '../features/favorites/presentation/blocs/cubit/favorites_cubit.dart';
import '../features/home_tab/data/datasources/home_remote_data_source.dart';
import '../features/home_tab/data/repositories/home_repository.dart';
import '../features/home_tab/presentation/cubit/home_cubit.dart';
import '../features/j_carousal_products/data/datasources/j_carousal_products_list_remote_data_source.dart';
import '../features/j_carousal_products/data/repositories/j_carousal_products_repository_impl.dart';
import '../features/j_carousal_products/presentation/blocs/cubit/j_carousal_products_cubit.dart';
import '../features/layout/presentation/cubit/main_layout_cubit.dart';
import '../features/orders/data/datasources/order_remote_data_source.dart';
import '../features/orders/data/repositories/order_repository_impl.dart';
import '../features/orders/presentation/blocs/order_cubit/order_cubit.dart';
import '../features/orders/presentation/blocs/order_details_cubit/order_details_cubit.dart';
import '../features/payment/data/datasources/payment_remote_data_source.dart';
import '../features/payment/data/repositories/payment_repository_impl.dart';
import '../features/payment/presentation/blocs/payment_cubit/payment_cubit.dart';
import '../features/product_details/data/datasources/product_details_remote_data_source.dart';
import '../features/product_details/data/repositories/product_details_repository_impl.dart';
import '../features/product_details/presentation/blocs/cubit/product_details_cubit.dart';
import '../features/search/data/datasources/search_remote_data_source.dart';
import '../features/search/data/repositories/search_repository.dart';
import '../features/search/presentation/blocs/home_search_bloc/search_bloc.dart';
import '../features/splash/data/datasources/splash_local_data_source.dart';
import '../features/splash/data/repositories/splash_repository_impl.dart';
import '../features/splash/presentation/splash_cubit/splash_cubit.dart';
import '../features/wallet/data/datasources/wallet_remote_data_source.dart';
import '../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../features/wallet/presentation/blocs/wallet_cubit/wallet_cubit.dart';

///Implementing
///
///`Singleton` design pattern
///
///`Flyweight` design pattern
///
///to save specific objects from recreation
class Injector {
  final _flyweightMap = <String, dynamic>{};
  static final _singleton = Injector._internal();

  Injector._internal();
  factory Injector() => _singleton;

  //===================[SPLASH_CUBIT]===================
  SplashCubit get splashCubit => SplashCubit(
        notificationDataSource,
        dynamicLinkService,
        splashRepository,
      );

  SplashRepository get splashRepository => _flyweightMap['splashRepository'] ??=
      SplashRepositoryImpl(splashLocalDataSource);
  SplashLocalDataSource get splashLocalDataSource =>
      _flyweightMap['splashLocalDataSource'] ??=
          SplashLocalDataSourceImpl(cacheService);

  //===================[Intro_CUBIT]===================
  IntroCubit get introCubit => IntroCubit(introRepository, launcherService);

  IntroRepository get introRepository =>
      _flyweightMap['introRepository'] ??= IntroRepositoryImpl(
        introRemoteDataSource,
        introLocalDataSource,
      );
  IntroRemoteDataSource get introRemoteDataSource =>
      _flyweightMap['introRemoteDataSource'] ??=
          IntroRemoteDataSourceImpl(networkService);

  IntroLocalDataSource get introLocalDataSource =>
      _flyweightMap['introLocalDataSource'] ??=
          IntroLocalDataSourceImpl(cacheService);

  //===================[TOPICS_CUBIT]===================
  TopicsCubit get topicsCubit => TopicsCubit(authRepository);

  //===================[NOTIFICATIONS_CUBIT]===================
  NotificationsCubit get notificationsCubit =>
      NotificationsCubit(notificationsRepository);

  NotificationsRepository get notificationsRepository =>
      _flyweightMap['notificationsRepository'] ??=
          NotificationsRepositoryImpl(notificationsRemoteDataSource);

  NotificationsRemoteDataSource get notificationsRemoteDataSource =>
      _flyweightMap['notificationsRemoteDataSource'] ??=
          NotificationsRemoteDataSourceImpl(networkService);

  //===================[AUTH_CUBIT]===================
  AuthCubit get authCubit => AuthCubit(
        authRepository: authRepository,
      );

  AuthRepository get authRepository =>
      _flyweightMap['authRepository'] ??= AuthRepositoryImpl(
        authRemoteDataSource,
        authLocalDataSource,
        appleExternalDataSource,
        googleExternalDataSource,
        deviceTypeDataSource,
        notificationDataSource,
      );

  AuthRemoteDataSource get authRemoteDataSource =>
      _flyweightMap['authRemoteDataSource'] ??=
          AuthRemoteDataSourceImpl(networkService);
  AuthLocalDataSource get authLocalDataSource =>
      _flyweightMap['authLocalDataSource'] ??=
          AuthLocalDataSourceImpl(cacheService);

  //===================[MAIN_LAY_OUT_CUBIT]===================
  MainLayoutCubit get mainLayoutCubit => MainLayoutCubit();

  //===================[SEARCH_BLOC]===================
  SearchBloc get searchBloc => SearchBloc(searchRepository);

  SearchRepository get searchRepository => _flyweightMap['searchRepository'] ??=
      SearchRepositoryImpl(searchRemoteDataSource: searchRemoteDataSource);

  SearchRemoteDataSource get searchRemoteDataSource =>
      _flyweightMap['searchRemoteDataSource'] ??=
          SearchRemoteDataSourceImpl(networkService);

  //===================[HOME_CUBIT]===================
  HomeCubit get homeCubit => HomeCubit(homeRepository, launcherService);

  HomeRepository get homeRepository =>
      _flyweightMap['homeRepository'] ??= HomeRepositoryImpl(
        homeRemoteDataSource,
      );
  HomeRemoteDataSource get homeRemoteDataSource =>
      _flyweightMap['homeRemoteDataSource'] ??=
          HomeRemoteDataSourceImpl(networkService);

  //===================[FAVORITES_CUBIT]===================

  FavoritesCubit get favoritesCubit => FavoritesCubit(favoritesRepository);

  FavoritesRepository get favoritesRepository =>
      _flyweightMap['favoritesRepository'] ??= FavoritesRepositoryImpl(
          favoritesRemoteDataSource: favoritesRemoteDataSource);

  FavoritesRemoteDataSource get favoritesRemoteDataSource =>
      _flyweightMap['favoritesRemoteDataSource'] ??=
          FavoritesRemoteDataSourceImpl(networkService);

  //===================[CATEGORY_PRODUCTS_CUBIT]===================
  CategoryProductsCubit get categoryProductsCubit => CategoryProductsCubit(
      categoryProductsRepository: categoryProductsRepository);

  CategoryProductsRepository get categoryProductsRepository =>
      _flyweightMap['categoryProductsRepository'] ??=
          CategoryProductsRepositoryImpl(categoryProductsRemoteDataSource);

  CategoryProductsRemoteDataSource get categoryProductsRemoteDataSource =>
      _flyweightMap['categoryProductsRemoteDataSource'] ??=
          CategoryProductsRemoteDataSourceImpl(networkService);

  //===================[CATEGORIES_CUBIT]===================
  CategoriesCubit get categoriesCubit =>
      CategoriesCubit(categoriesRepository: categoriesRepository);

  CategoriesRepository get categoriesRepository =>
      _flyweightMap['categoriesRepository'] ??=
          CategoriesRepositoryImpl(categoriesRemoteDataSource);

  CategoriesRemoteDataSource get categoriesRemoteDataSource =>
      _flyweightMap['categoriesRemoteDataSource'] ??=
          CategoriesRemoteDataSourceImpl(networkService);
  //===================[BRAND_PRODUCTS_CUBIT]===================
  BrandProductsCubit get brandProductsCubit =>
      BrandProductsCubit(brandProductsRepository: brandProductsRepository);

  BrandProductsRepository get brandProductsRepository =>
      _flyweightMap['brandProductsRepository'] ??=
          BrandProductsRepositoryImpl(brandProductsRemoteDataSource);

  BrandProductsRemoteDataSource get brandProductsRemoteDataSource =>
      _flyweightMap['brandProductsRemoteDataSource'] ??=
          BrandProductsRemoteDataSourceImpl(networkService);

  //===================[BRANDS_CUBIT]===================
  BrandsCubit get brandsCubit =>
      BrandsCubit(brandsRepository: brandsRepository);

  BrandsRepository get brandsRepository => _flyweightMap['brandsRepository'] ??=
      BrandsRepositoryImpl(brandsRemoteDataSource);

  BrandsRemoteDataSource get brandsRemoteDataSource =>
      _flyweightMap['brandsRemoteDataSource'] ??=
          BrandsRemoteDataSourceImpl(networkService);

  //===================[J_CAROUSAL_PRODUCTS_CUBIT]===================
  JCarousalProductsCubit get jCarousalProductsCubit => JCarousalProductsCubit(
      jCarousalProductsRepository: jCarousalProductsRepository);

  JCarousalProductsRepository get jCarousalProductsRepository =>
      _flyweightMap['JCarousalProductsRepository'] ??=
          JCarousalProductsRepositoryImpl(jCarousalProductsRemoteDataSource);

  JCarousalProductsRemoteDataSource get jCarousalProductsRemoteDataSource =>
      _flyweightMap['JCarousalProductsRemoteDataSource'] ??=
          JCarousalProductsRemoteDataSourceImpl(networkService);

  //===================[CART_CUBIT]===================
  CartCubit get cartCubit => CartCubit(cartRepository);

  CartRepository get cartRepository => _flyweightMap['cartRepository'] ??=
      CartRepositoryImpl(cartRemoteDataSource: cartRemoteDataSource);

  CartRemoteDataSource get cartRemoteDataSource =>
      _flyweightMap['cartRemoteDataSource'] ??=
          CartRemoteDataSourceImpl(networkService);

  //===================[ORDER_CUBIT]===================
  OrderCubit get orderCubit => OrderCubit(orderRepository);

  OrderRepository get orderRepository => _flyweightMap['orderRepository'] ??=
      OrderRepositoryImpl(orderRemoteDataSource);

  OrderRemoteDataSource get orderRemoteDataSource =>
      _flyweightMap['orderRemoteDataSource'] ??=
          OrderRemoteDataSourceImpl(networkService);

  //===================[ORDER_DETAILS_CUBIT]===================
  OrderDetailsCubit get orderDetailsCubit => OrderDetailsCubit(orderRepository);

  //===================[ADDRESS_CUBIT]===================
  AddressCubit get addressCubit =>
      AddressCubit(addressRepository: addressRepository);

  AddressRepository get addressRepository =>
      _flyweightMap['addressRepository'] ??=
          AddressRepositoryImpl(addressRemoteDataSource);

  AddressRemoteDataSource get addressRemoteDataSource =>
      _flyweightMap['addressRemoteDataSource'] ??=
          AddressRemoteDataSourceImpl(networkService);

  //===================[CHECKOUT_CUBIT]===================
  CheckoutCubit get checkoutCubit => CheckoutCubit(
        checkoutRepository,
        cartRepository,
        walletRepository,
        shareService,
      );

  CheckoutRepository get checkoutRepository =>
      _flyweightMap['checkoutRepository'] ??= CheckoutRepositoryImpl(
        checkoutRemoteDataSource,
        deviceTypeDataSource,
      );

  CheckoutRemoteDataSource get checkoutRemoteDataSource =>
      _flyweightMap['checkoutRemoteDataSource'] ??=
          CheckoutRemoteDataSourceImpl(networkService);

  //===================[WALLET_CUBIT]===================
  WalletCubit get walletCubit => WalletCubit(walletRepository);

  WalletRepository get walletRepository => _flyweightMap['walletRepository'] ??=
      WalletRepositoryImpl(walletRemoteDataSource);

  WalletRemoteDataSource get walletRemoteDataSource =>
      _flyweightMap['walletRemoteDataSource'] ??=
          WalletRemoteDataSourceImpl(networkService);

  //===================[WALLET_WITH_DRAW_CUBIT]===================
  WalletWithDrawCubit get walletWithDrawCubit =>
      WalletWithDrawCubit(walletRepository);

//   //===================[NOTIFICATION_CUBIT]===================
//   NotificationCubit get notificationCubit =>
//       NotificationCubit(notificationRepository);

//   NotificationRepository get notificationRepository =>
//       _flyweightMap['notificationRepository'] ??= NotificationRepositoryImpl(
//           notificationRemoteDataSource: notificationRemoteDataSource);

//   NotificationRemoteDataSource get notificationRemoteDataSource =>
//       _flyweightMap['notificationRemoteDataSource'] ??=
//           NotificationRemoteDataSourceImpl(networkService);

  //===================[ACCOUNT_CUBIT]===================
  AccountCubit get accountCubit => AccountCubit(launcherService);

//   //===================[MY_WALLET_CUBIT]===================
//   WalletCubit get walletCubit => WalletCubit(paymentRepository);

//===================[PAYMENT_CUBIT]===================
  PaymentCubit get paymentCubit =>
      PaymentCubit(paymentRepository, cartRepository);

  PaymentRepository get paymentRepository =>
      _flyweightMap['paymentRepository'] ??= PaymentRepositoryImpl(
        paymentRemoteDataSource,
        deviceTypeDataSource,
      );

  PaymentRemoteDataSource get paymentRemoteDataSource =>
      _flyweightMap['paymentRemoteDataSource'] ??=
          PaymentRemoteDataSourceImpl(networkService);

//===================[PRODUCT_DETAILS_CUBIT]===================
  ProductDetailsCubit get productDetailsCubit => ProductDetailsCubit(
        productDetailsRepository,
        cartRepository,
        favoritesRepository,
        shareService,
        dynamicLinkService,
      );

  ProductDetailsRepository get productDetailsRepository =>
      _flyweightMap['productDetailsRepository'] ??=
          ProductDetailsRepositoryImpl(productDetailsRemoteDataSource);

  ProductDetailsRemoteDataSource get productDetailsRemoteDataSource =>
      _flyweightMap['productDetailsRemoteDataSource'] ??=
          ProductDetailsRemoteDataSourceImpl(networkService);

//   //===================[CORE_DATA]===================

  LauncherService get launcherService =>
      _flyweightMap['launcherService'] ??= LauncherServiceImpl();

//   ClickCounterRepository get clickCounterRepository =>
//       _flyweightMap['clickCounterRepository'] ??=
//           ClickCounterRepositoryImpl(clickCounterRemoteDataSource);

//   ClickCounterRemoteDataSource get clickCounterRemoteDataSource =>
//       _flyweightMap['clickCounterRemoteDataSource'] ??=
//           ClickCounterRemoteDataSourceImpl(networkService);

//   LocationHelper get locationHelper =>
//       _flyweightMap['locationHelper'] ??= LocationHelperImpl();

  DeviceTypeDataSource get deviceTypeDataSource =>
      _flyweightMap['deviceTypeDataSource'] ??= DeviceTypeDataSourceImpl();

  NetworkService get networkService => _flyweightMap['networkService'] ??=
      NetworkServiceImpl(networkServiceUtil);

  NetworkServiceUtil get networkServiceUtil =>
      _flyweightMap['networkServiceUtil'] ??=
          NetworkServiceUtilImpl(cacheService);

  CacheService get cacheService =>
      _flyweightMap['cacheService'] ??= CacheServiceImpl();

  AppInfoService get appInfoService =>
      _flyweightMap['appInfoService'] ??= AppInfoServiceImpl();

  NotificationService get notificationService =>
      _flyweightMap['notificationService'] ??= NotificationService();

  NotificationDataSource get notificationDataSource =>
      _flyweightMap['notificationDataSource'] ??=
          NotificationDataSourceImpl(notificationService);

  ShareService get shareService =>
      _flyweightMap['shareService'] ??= ShareServiceImpl();

  DynamicLinkService get dynamicLinkService =>
      _flyweightMap['dynamicLinkService'] ??= DynamicLinkServiceImpl();

  MyFatoorahService get myFatoorahService =>
      _flyweightMap['myFatoorahService'] ??= MyFatoorahServiceImpl();

  ExternalLoginDataSource get appleExternalDataSource =>
      _flyweightMap['appleExternalDataSource'] ??=
          AppleExternalLoginDataSourceImpl();
  ExternalLoginDataSource get googleExternalDataSource =>
      _flyweightMap['googleExternalDataSource'] ??=
          GoogleExternalLoginDataSourceImpl();
}
