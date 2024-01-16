import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/media_query_values.dart';
import '../../core/utils/type_defs.dart';
import '../stateful/default_button.dart';
import 'back_button.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({
    Key? key,
    double? height,
    EdgeInsets padding = EdgeInsets.zero,
    bool withBackButton = false,
    FutureCallback? onRefreshPage,
  })  : _height = height,
        _padding = padding,
        _withBackButton = withBackButton,
        _onRefreshPage = onRefreshPage,
        super(key: key);

  final double? _height;
  final EdgeInsets _padding;
  final bool _withBackButton;
  final FutureCallback? _onRefreshPage;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.height;
    return Container(
      height: _height ?? screenHeight * 0.7,
      padding: _padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_withBackButton) const CustomBackButton(),
          const Spacer(),
          SvgPicture.asset('lib/res/assets/no_internet_connection_icon.svg'),
          const SizedBox(height: 16.0),
          Text(
            'sorry_no_result_found'.tr(),
            style: Theme.of(context).textTheme.headline2,
          ),
          const Spacer(),
          _buildRefreshButton(context),
        ],
      ),
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return DefaultButton(
      label: 'refresh_page'.tr(),
      isExpanded: true,
      padding: const EdgeInsets.all(12.0),
      onPressed: _onRefreshPage,
    );
  }
}
