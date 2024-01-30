import 'package:flutter_svg/svg.dart';
import '../../../../core/data/models/notification_model.dart';
import '../../../layout/presentation/cubit/main_layout_cubit.dart';
import '../blocs/order_cubit/notifications_cubit.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_cached_network_image.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/di/injector.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

class NotificationsPage extends StatefulWidget {
  static const routeName = '/NotificationsPage';
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().notificationsCubit
        ..getNotifications().whenComplete(() {
          // final mainLayoutCubit = context.read<MainLayoutCubit>();
          // mainLayoutCubit.isUserHasNewNotifications();
        }),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: Column(
            children: [
              const InnerPagesAppBar(label: 'notifications'),
              BlocConsumer<NotificationsCubit, NotificationsState>(
                listener: (context, state) {
                  if (state.isError)
                    showSnackBar(context, message: state.errorMessage);
                },
                builder: (context, state) {
                  if (state.isInitial ||
                      (state.isLoading && state.notifications == null))
                    return const Expanded(
                      child: CustomLoading(),
                    );

                  return Expanded(
                    child: _buildNotificationsList(context,
                        notificationModel: state.notifications),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
    BuildContext context, {
    required NotificationModel? notificationModel,
  }) {
    final notificationsCubit = context.read<NotificationsCubit>();

    return notificationModel?.data?.isNotEmpty == true
        ? LazyLoadScrollView(
            onEndOfPage: () => notificationsCubit.getMoreNotifications(),
            isLoading: notificationsCubit.state.isLoadingMore,
            child: RefreshIndicator(
                onRefresh: () => notificationsCubit.refresh(),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: notificationModel!.data!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16.0);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var notification = notificationModel.data![index];
                    return _buildNotificationCard(notification: notification);
                  },
                )),
          )
        : EmptyPageMessage(
            //heightRatio: 0.6,
            isSVG: false,
            title: 'no_notification_found',
            subTitle: "check_our_best",
            svgImage: 'fish_icon',
            onRefresh: () => notificationsCubit.refresh(),
          );
  }

  // void _goToNotificationsPage(BuildContext context, int id) {
  //   NavigatorHelper.of(context).push(MaterialPageRoute(builder: (_) {
  //     return OrderDetailsPage(orderId: id);
  //   }));
  // }
}

Widget _buildNotificationCard({required Data notification}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: AppColors.SECONDARY_COLOR,
          child: SvgPicture.asset(
            'lib/res/assets/bell_icon.svg',
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleText(text: notification.title ?? ''),
            const SizedBox(height: 8.0),
            SubtitleText(text: notification.body ?? ''),
            if (notification.image != null &&
                notification.image!.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              CustomCachedNetworkImage(
                imageUrl: notification.image,
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              )
            ]
          ],
        ))
      ],
    ),
  );
}
