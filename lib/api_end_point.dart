import 'main.dart';

abstract class ApiEndPoint {
  static const domainUrl = 'https://alsalmankw.com';

  static const BASE_URL =
      isRelease ? '$domainUrl/frontendapi' : '$domainUrl/frontendapi';

  static const _REQUEST_URL = BASE_URL;
  //Auth

  static const sign_up = '$_REQUEST_URL/customer/register';
  static const login = '$_REQUEST_URL/authenticate/gettoken';
  static const loginAsGuest = '$_REQUEST_URL/authenticate/gettoken';
  static const userDetails = '$_REQUEST_URL/customer/info';
  static const uploadAvatar = '$_REQUEST_URL/customer/uploadavatar';
  static const uploadAvatarFile = '$_REQUEST_URL/customer/UploadByFileAvatar';
  static const getAvatar = '$_REQUEST_URL/customer/avatar';
  static const deleteAvatar = '$_REQUEST_URL/customer/removeavatar';
  static const google_login = '$_REQUEST_URL/authenticate/gettokenbygoogle';
  static const apple_login = '$_REQUEST_URL/authenticate/gettokenbyapple';

  static const apple_redirect_url = '$BASE_URL/callbacks/sign_in_with_apple';
  static const forget_password = '$_REQUEST_URL/customer/passwordrecoverysend';
  static const change_password = '$_REQUEST_URL/customer/changepassword';
  static const deleteAccount = '$_REQUEST_URL/customer/deletemyaccount';
  static const changeUserLanguage = '$_REQUEST_URL/common/setlanguage/';
  static const getTopicData = '$_REQUEST_URL/topic/gettopicdetails/';

  /// home page
  // static const  homeCategory = '$_REQUEST_URL/Catalog/GetRootCategories';

  static const getHomeCategories =
      '$_REQUEST_URL/catalog/gethomepagecategories';
  static const getMainCategory = '$_REQUEST_URL/banner/GetRootCategories';

  /// Intro page
  static const getLandingBanner = '$_REQUEST_URL/banner/list?tag=OnBoarding';

  // Notifications
  static const String getNotificationsList =
      '$_REQUEST_URL/pushNotification/usernotification/list';
  static const String getIsUserHasNewNotifications =
      '$_REQUEST_URL/pushNotification/customer/read';

  // static const getHomeNewProductsSection =
  //     '$_REQUEST_URL/product/getrecentlyproducts';

  // static const  subCategory =
  //     '$_REQUEST_URL/Catalog/GetSubCategories?categoryId=';
  static const getCarousels = '$_REQUEST_URL/baqah/jcarousel/getallcarousels';
  // static const  trendingNow =
  //     '$_REQUEST_URL/Product/GetMostVisited?pageNumber=0&pageSize=';
  // static const  productsBySubCategory =
  //     '$_REQUEST_URL/Product/GetProducts';
  // static const  homeBanner = '$_REQUEST_URL/banner/list';
  // static const  homeBannerWithId =
  //     '$_REQUEST_URL/banner/list?CategoryId=';

  static const getHomeBanner = '$_REQUEST_URL/banner/list?tag=homepageslider';
  static const getCarouselFirstBanner =
      '$_REQUEST_URL/banner/list?tag=Carousel1';
  static const getCarouselSecondBanner =
      '$_REQUEST_URL/banner/list?tag=Carousel2';
  static const getCarouselThirdBanner =
      '$_REQUEST_URL/banner/list?tag=Carousel3';
  static const getCategoriesBanner =
      '$_REQUEST_URL/banner/list?tag=Categoriesbanner';

  static const getCategoryBanner = '$_REQUEST_URL/banner/list';

  // static const  getNotificationsList =
  //     '$_REQUEST_URL/PushNotification/userNotification/List';

  static const getUserOrders = '$_REQUEST_URL/order/customerorders';

  static const getOrderDetails = '$_REQUEST_URL/order/details/';

  // static const  deleteAllFavoriteItems =
  //     '$_REQUEST_URL/FavoriteProduct/DeleteAll';
  static const getUserAddresses = '$_REQUEST_URL/customer/addresses';

  static const addAddress = '$_REQUEST_URL/customer/addressadd';
  static const getProducts = '$_REQUEST_URL/baqah/product/getproducts';

  /// cart
  static const checkCartProductsAvailability =
      '$_REQUEST_URL/baqah/shoppingcart/check-availibility';
  static const refreshCartItems = '$_REQUEST_URL/baqah/shoppingcart/adjust';
  static const getCart = '$_REQUEST_URL/shoppingcart/cart';
  static const addToCartFromCatalog =
      '$_REQUEST_URL/shoppingcart/addproducttocartfromcatalog/';
  static const addToCart =
      '$_REQUEST_URL/shoppingcart/addproducttocartfromdetails/';
  static const removeFromCart =
      '$_REQUEST_URL/shoppingcart/deleteshoppingcartitem/';
  static const addCoupon =
      '$_REQUEST_URL/shoppingcart/applydiscountcoupon?discountcouponcode=';

  static const APPLY_COUPON = '$_REQUEST_URL/shoppingcart/applydiscountcoupon';
  static const REMOVE_COUPON =
      '$_REQUEST_URL/shoppingcart/removediscountbycouponcode';

  static const UPDATE_CART = '$_REQUEST_URL/shoppingcart/updatecart';
  static const PAYMENT_SUMMARY = '$_REQUEST_URL/checkout/paymentsummery';
  static const SET_SHIPPING_ADDRESS =
      '$_REQUEST_URL/checkout/selectshippingaddress/';
  static const SET_BILLING_ADDRESS =
      '$_REQUEST_URL/checkout/selectbillingaddress/';
  static const GET_NORMAL_SHIPPING_METHODS =
      '$_REQUEST_URL/checkout/shippingmethod';
  static const GET_DELIVERY_SHIPPING_METHODS =
      '$_REQUEST_URL/scheduledelivery/deliveries';
  static const GET_DELIVERY_SHIPPING_DATES = '$_REQUEST_URL/scheduledelivery/';
  static const GET_DELIVERY_SHIPPING_TIMES =
      '$_REQUEST_URL/scheduledelivery/timeslots';
  static const SET_SHIPPING_METHODS =
      '$_REQUEST_URL/checkout/selectshippingmethod';

  static const SET_SHIPPING_TIME = '$_REQUEST_URL/scheduledelivery/timeslots';

  static const NOTIFY_ME =
      '$_REQUEST_URL/baqah/backinstocksubscription/subscribepopuppost/';

  // Favorites
  static const getFavorites =
      '$_REQUEST_URL/favoriteproduct/getfavoriteproducts';
  static const ADD_TO_WISHLIST = '$_REQUEST_URL/favoriteproduct/add';
  static const REMOVE_FROM_WISHLIST = '$_REQUEST_URL/favoriteproduct/delete';
  static const REMOVE_ALL_WISHLIST = '$_REQUEST_URL/favoriteproduct/deleteall';

  // Wallet

  static const getWalletBalance = '$_REQUEST_URL/wallet/amount';
  static const getUserTransactions = '$_REQUEST_URL/wallet/history/list';
  static const getWalletStatus = '$_REQUEST_URL/wallet/usewalletcredit';
  static const changeWalletStatus = '$_REQUEST_URL/wallet/usewalletcredit';
  static const submitWalletWithdrawRequest =
      '$_REQUEST_URL/wallet/withdrawrequest';

  /// check out
  static const getAddress = '$_REQUEST_URL/customer/addresses';
  static const getAddressById = '$_REQUEST_URL/customer/addressedit/';
  static const deleteAddress = '$_REQUEST_URL/customer/addressdelete/';
  static const getCountries = '$_REQUEST_URL/customer/addressadd';
  static const getStates = '$_REQUEST_URL/country/getstatesbycountryid/';

  static const getShippingMethod = '$_REQUEST_URL/Checkout/ShippingMethod';
  static const getPaymentMethod = '$_REQUEST_URL/Checkout/PaymentMethod';
  static const setPaymentMethod = '$_REQUEST_URL/Checkout/SelectPaymentMethod';
  static const paymentInfoMethod = '$_REQUEST_URL/Checkout/paymentinfo';
  static const paymentSummeryMethod = '$_REQUEST_URL/Checkout/PaymentSummery';
  static const confirmOrder =
      '$_REQUEST_URL/scheduledelivery/order/confirmorder';
  static const reOrder = '$_REQUEST_URL/order/reorder/';
  static const getOrderPDF = '$_REQUEST_URL/order/getpdfinvoice/';
  static const createOrderShareLink =
      '$_REQUEST_URL/orderpaymentlink/createpaymenturl';
  static const deleteItemCart =
      '$_REQUEST_URL/ShoppingCart/DeleteShoppingCartItem/';
  static const verifyByInvoiceId =
      '$_REQUEST_URL/Checkout/tap/payment/verifyByInvoiceId';
  static const verifyByPaymentId =
      '$_REQUEST_URL/Checkout/tap/payment/verifyPaymentId?paymentId=';

  static const notificationToken = '$_REQUEST_URL/pushnotification/token';

  static const activateNotification =
      '$_REQUEST_URL/pushnotification/token/active';

  static const deActivateNotification =
      '$_REQUEST_URL/pushnotification/token/deactive';

  static const changeAdTrackingNotification =
      '$_REQUEST_URL/baqah/customer/enabletracking';

  // static const  getSubCategoriesByCategoryName =
  //     '$_REQUEST_URL/Catalog/GetCategoriesByNames';

  // static const  requestRecoveryCode =
  //     '$_REQUEST_URL/Customer/PasswordRecoverySend';

  static const getProductDetailsData = '$_REQUEST_URL/baqah/product/';
  static const getBookingTimes = '$_REQUEST_URL/booking/timeslot/list';
  static const GET_PRODUCT_DETAILS_CONDITIONAL_ATTRIBUTES_DATA =
      '$_REQUEST_URL/Product/GetConditionAttribute';
  static const GET_PRODUCT_DETAILS_COMBINATION_ATTRIBUTES_DATA =
      '$_REQUEST_URL/baqah/product/getproductcombinations/';

  static const getFilterData =
      '$_REQUEST_URL/baqah/filter/getspecificationsbygroupname';

  static const getPriceRangeData =
      '$_REQUEST_URL/baqah/filter/getproductpricerange';

  static const getTagsData = '$_REQUEST_URL/baqah/product/tags';
  static const getCategoryBrandsData =
      '$_REQUEST_URL/baqah/filter/getbrandsbycategoryids';
  static const getSubCategories = '$_REQUEST_URL/catalog/getsubcategories';

  static const getAllBrandsData = '$_REQUEST_URL/catalog/manufacturerall';

  static const getBrandBrandsData = '$_REQUEST_URL/catalog/getmanufacturer/';
}
