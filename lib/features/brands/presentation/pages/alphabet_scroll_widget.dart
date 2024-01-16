import 'package:azlistview/azlistview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/title_text.dart';

import '../../data/models/brand_model/brand_model.dart';

class AlphabetScrollPage extends StatefulWidget {
  const AlphabetScrollPage({Key? key, this.items, required this.onPress})
      : super(key: key);

  final List<BrandModel>? items;
  final ValueChanged<BrandModel> onPress;

  @override
  State<AlphabetScrollPage> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<AZItem> items = [];
  Map<String, bool> indexData = {};

  @override
  void initState() {
    super.initState();
    initList(widget.items);

    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: items,
      indexBarData: indexData.keys.toList(),
      indexBarMargin: const EdgeInsets.all(16),
      indexBarItemHeight: 20.0,
      indexBarAlignment: context.locale == const Locale('en')
          ? Alignment.centerRight
          : Alignment.centerLeft,
      indexBarOptions: IndexBarOptions(
          needRebuild: true,
          hapticFeedback: true,
          selectItemDecoration: const BoxDecoration(color: Colors.transparent),
          textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 16,
                color: AppColors.GREY_NORMAL_COLOR,
              ),
          selectTextStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 16,
                color: AppColors.ACCENT_COLOR,
              )),
      physics: const BouncingScrollPhysics(),
      indexBarWidth: 16.0,
      hapticFeedback: true,
      itemCount: items.length,
      itemBuilder: (_, index) {
        AZItem item = items[index];
        return _buildListItem(item);
      },
    );
  }

  void initList(List<BrandModel>? items) {
    this.items = items!
        .map(
          (e) => AZItem(
            tag: e.name?[0].toUpperCase(),
            title: e.name,
          ),
        )
        .toList();

    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
  }

  Widget _buildListItem(AZItem item) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;

    indexData[tag] = true;

    return Column(
      children: [
        Offstage(
          offstage: offstage,
          child: buildHeader(tag),
        ),
        ListTile(
          title: TitleText(text: item.title!),
          onTap: () {
            widget.onPress(
                widget.items!.where((e) => e.name! == item.title!).first);
          },
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  buildHeader(tag) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TitleText.large(
        text: '$tag',
        color: AppColors.ACCENT_COLOR,
      ),
    );
  }
}

class AZItem extends ISuspensionBean {
  final String? title;
  final String? tag;

  AZItem({
    required this.title,
    required this.tag,
  });

  @override
  String getSuspensionTag() {
    return tag!;
  }
}
