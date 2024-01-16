import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/media_query_values.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    Key? key,
    double? heightFactor = 0.5,
  })  : assert(heightFactor == null || heightFactor <= 1.0),
        _heightFactor = heightFactor,
        super(key: key);

  final double? _heightFactor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _heightFactor == null ? null : context.height * _heightFactor!,
      child: Center(
        child: Text(
          'sorry_no_result_found'.tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
