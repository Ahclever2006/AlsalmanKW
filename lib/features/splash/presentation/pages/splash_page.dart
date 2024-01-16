import 'package:alsalman_app/core/utils/media_query_values.dart';
import 'package:alsalman_app/shared_widgets/stateful/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../cart_tab/presentation/cubit/cart_cubit.dart';
import '../../../intro/presentation/pages/intro_page.dart';
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
    final splashCubit = context.read<SplashCubit>();
    final authCubit = context.read<AuthCubit>();
    final cartCubit = context.read<CartCubit>();
    // final languageCode = context.locale.languageCode;

    splashCubit.init(
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
      'en',
    );

    _controller = VideoPlayerController.asset('lib/res/assets/splash_video.mp4')
      ..addListener(() {
        if (_controller.value.isCompleted) {
          splashCubit.changeVideoStatus();
        }
      })
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
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context, message: state.errorMessage);
        } else if (state.isLoaded && state.isVideoCompleted == true) {
          if (state.isFirstLunch == false) _goToHomePage(context);
        }
      },
      child: CustomAppPage(
        safeBottom: false,
        child:
            // SvgPicture.asset('lib/res/assets/app_logo.svg'),
            Stack(
          children: [
            VideoPlayer(_controller),
            Positioned(
              bottom: context.height * 0.10,
              left: 48.0,
              right: 48.0,
              child: BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  if (state.isLoaded && state.isFirstLunch == true)
                    return Material(
                      type: MaterialType.transparency,
                      child: DefaultButton(
                          label: 'explore'.tr(),
                          onPressed: () {
                            _goToIntroPage(context);
                          }),
                    );
                  else
                    return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacementNamed(MainLayOutPage.routeName);
  }

  void _goToIntroPage(BuildContext context) {
    NavigatorHelper.of(context).pushReplacementNamed(IntroPage.routeName);
  }
}
