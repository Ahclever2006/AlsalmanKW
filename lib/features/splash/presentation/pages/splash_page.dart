import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../di/injector.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../layout/presentation/pages/main_layout_page.dart';
import '../splash_cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashPage';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('lib/res/assets/splash_video.mp4')
      ..initialize().then((_) {
        _controller.play();
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final cartCubit = context.read<CartCubit>();

    final languageCode = context.locale.languageCode;

    return BlocProvider(
      create: (_) => Injector().splashCubit
        ..init(
          authCubit.init,
          () async {
            if (!authCubit.state.isUserHaveToken) {
              await authCubit.loginAsGuest();
              await cartCubit.loadCart();
            } else {
              if (DateTime.now()
                      .difference(
                          DateTime.parse(authCubit.state.tokenExpirationDate!))
                      .inDays >=
                  -2) {
                await authCubit.refreshToken();
              }
              await cartCubit.loadCart();
            }
          },
          languageCode,
        ),
      lazy: false,
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.isError) {
            showSnackBar(context, message: state.errorMessage);
          } else if (state.isLoaded) {
            _goToHomePage(context);
          }
        },
        child: CustomAppPage(
          safeBottom: false,
          child:
              // SvgPicture.asset('lib/res/assets/app_logo.svg'),
              VideoPlayer(_controller),
        ),
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacementNamed(MainLayOutPage.routeName);
  }
}
