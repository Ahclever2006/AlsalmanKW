import 'package:flutter/material.dart';
import '../features/account_tab/presentation/pages/change_password_page.dart';
import '../features/account_tab/presentation/pages/contact_us_page.dart';
import '../features/account_tab/presentation/pages/delete_account_page.dart';
import '../features/account_tab/presentation/pages/language_chooser_page.dart';

import '../features/account_tab/presentation/pages/profile_page.dart';
import '../features/address/presentation/pages/add_address_screen.dart';
import '../features/address/presentation/pages/address_screen.dart';
import '../features/auth/presentation/pages/forget_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_success_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/brands/presentation/pages/brands_page.dart';
import '../features/categories/presentation/pages/categories_page.dart';
import '../features/check_out/presentation/pages/checkout_page.dart';
import '../features/favorites/presentation/pages/favorites_products_page.dart';
import '../features/intro/presentation/pages/intro_page.dart';
import '../features/layout/presentation/pages/main_layout_page.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';
import '../features/orders/presentation/pages/orders_page.dart';
import '../features/search/presentation/pages/search_products_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/wallet/presentation/pages/wallet_page.dart';

final routes = <String, WidgetBuilder>{
  SplashPage.routeName: (context) => const SplashPage(),
  IntroPage.routeName: (context) => const IntroPage(),
  MainLayOutPage.routeName: (context) => const MainLayOutPage(),
  FavoritesProductsPage.routeName: (context) => const FavoritesProductsPage(),
  SearchProductsPage.routeName: (context) => const SearchProductsPage(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  AddressesScreen.routeName: (context) => const AddressesScreen(),
  AddAddressPage.routeName: (context) => const AddAddressPage(),
  OrdersPage.routeName: (context) => const OrdersPage(),
  CheckoutPage.routeName: (context) => const CheckoutPage(),
  LanguageChooserPage.routeName: (context) => const LanguageChooserPage(),
  BrandsPage.routeName: (context) => const BrandsPage(),
  LoginPage.routeName: (context) => const LoginPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  ForgetPasswordPage.routeName: (context) => const ForgetPasswordPage(),
  WalletPage.routeName: (context) => const WalletPage(),
  ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),
  ContactUsPage.routeName: (context) => const ContactUsPage(),
  CategoriesPage.routeName: (context) => const CategoriesPage(),
  NotificationsPage.routeName: (context) => const NotificationsPage(),
  DeleteAccountPage.routeName: (context) => const DeleteAccountPage(),
  RegisterSuccessPage.routeName: (context) => const RegisterSuccessPage()
};
