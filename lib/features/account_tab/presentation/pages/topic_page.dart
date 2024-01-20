import 'package:flutter_svg/svg.dart';
import 'package:gif/gif.dart';

import '../blocs/topics_cubit/topics_cubit.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/enums/topic_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../di/injector.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';

class TopicPage extends StatefulWidget {
  static const routeName = '/TopicPage';
  const TopicPage({required this.id, Key? key}) : super(key: key);

  final int id;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> with TickerProviderStateMixin {
  late final GifController _controller;
  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector().topicsCubit..getTopicsData(widget.id),
      child: CustomAppPage(
        safeTop: true,
        child: Scaffold(
          body: Column(
            children: [
              InnerPagesAppBar(
                label: widget.id == TopicType.Privacy.value
                    ? 'privacy_policy'.tr()
                    : widget.id == TopicType.Terms.value
                        ? 'terms_of_use'.tr()
                        : 'about_us'.tr(),
              ),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocConsumer<TopicsCubit, TopicsState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
      },
      builder: (context, state) {
        if (state.isInitial || state.isLoading)
          return const CustomLoading(loadingStyle: LoadingStyle.Default);

        final cubit = context.read<TopicsCubit>();

        var content = state.topicContent?.body;
        return Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SvgPicture.asset(
                'lib/res/assets/app_logo.svg',
              ),
            ),
            const SizedBox(height: 16.0),
            TitleText.large(text: state.topicContent?.title ?? ''),
            const SizedBox(height: 16.0),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => cubit.refresh(widget.id),
                color: AppColors.PRIMARY_COLOR,
                backgroundColor: AppColors.ACCENT_COLOR,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: content?.isNotEmpty != true
                      ? EmptyPageMessage(
                          title: 'no_data_found',
                          onRefresh: () => cubit.refresh(widget.id),
                        )
                      : _buildAboutUsText(content!),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAboutUsText(String data) {
    return Html(
      data: data,
      style: {
        "body": Style(color: AppColors.PRIMARY_COLOR),
      },
    );

    // return HtmlWidget(
    //   data,
    //   customWidgetBuilder: (element) {
    //     String text;
    //     element.attributes.forEach((key, value) {
    //       log(value);
    //       if (value.toLowerCase().contains('gif')) {
    //         value = 'gif';
    //       }
    //     });

    //     // return Text(text);
    //   },
    // );
  }
}
