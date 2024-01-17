import 'package:alsalman_app/shared_widgets/stateless/subtitle_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/media_query_values.dart';

import '../../core/utils/connection_checker.dart';
import '../../res/style/app_colors.dart';
import '../stateful/default_button.dart';
import 'title_text.dart';

class EmptyPageMessage extends StatelessWidget {
  ///`heightRatio` from `0.0` to `1.0`
  const EmptyPageMessage({
    Key? key,
    String? title = 'Empty',
    String? subTitle,
    String? svgImage,
    bool isSVG = true,
    double heightRatio = 0.8,
    Color? textColor,
    RefreshCallback? onRefresh,
  })  : assert(title != null || svgImage != null,
            "title or svgImage must be not null"),
        _title = title,
        _subTitle = subTitle,
        _svgImage = svgImage,
        _isSVG = isSVG,
        _heightRatio = heightRatio,
        _textColor = textColor,
        _onRefresh = onRefresh,
        super(key: key);

  final String? _title;
  final String? _subTitle;
  final String? _svgImage;
  final bool _isSVG;
  bool get _isLink => _svgImage?.contains('http') ?? false;

  final double _heightRatio;
  final Color? _textColor;

  final RefreshCallback? _onRefresh;
  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final emptyMessageWidget = _buildEmptyMessageContent(
      context,
      height,
      title: _title,
      subTitle: _subTitle,
    );

    final normalEmptyMessage = _onRefresh == null
        ? emptyMessageWidget
        : RefreshIndicator(
            color: AppColors.ACCENT_COLOR,
            onRefresh: _onRefresh!,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              child: emptyMessageWidget,
            ),
          );
    return StreamBuilder<ConnectionCheckerResult>(
      stream: ConnectionChecker().connectionStream,
      builder: (context, snapshot) {
        final connectionResult = snapshot.data;
        final hasConnection = connectionResult?.newState ?? true;

        return hasConnection
            ? normalEmptyMessage
            : _buildEmptyMessageContent(
                context,
                height,
                title: 'connection_error'.tr(),
                showTryAgainButton: true,
              );
      },
    );
  }

  Widget _buildEmptyMessageContent(
    BuildContext context,
    double height, {
    String? title,
    String? subTitle,
    bool showTryAgainButton = false,
  }) {
    const assetsPath = "lib/res/assets/";

    Widget child = TitleText(
      text: title ?? 'Empty',
      textAlign: TextAlign.center,
      color: _textColor,
    );

    if (_svgImage != null)
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _isSVG
              ? _isLink
                  ? SvgPicture.network(
                      _svgImage!,
                      height: height * (_heightRatio - .40),
                    )
                  : SvgPicture.asset(
                      '$assetsPath$_svgImage.svg',
                      height: height * (_heightRatio - .40),
                    )
              : Image.asset('$assetsPath$_svgImage.png'),
          const SizedBox(height: 24.0),
          child,
          if (subTitle != null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              child: SubtitleText(
                text: subTitle,
                textAlign: TextAlign.center,
                color: AppColors.ACCENT_COLOR,
              ),
            ),
          if (showTryAgainButton) _buildTryAgainButton(),
        ],
      );
    else
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (showTryAgainButton) _buildTryAgainButton(),
        ],
      );

    return Container(
      alignment: Alignment.center,
      height: height * _heightRatio,
      child: child,
    );
  }

  Widget _buildTryAgainButton() {
    if (_onRefresh == null) return const SizedBox();
    return DefaultButton(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      padding: const EdgeInsets.all(8.0),
      backgroundColor: Colors.transparent,
      borderColor: AppColors.PRIMARY_COLOR,
      label: 'try_again'.tr(),
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        height: 1.0,
        color: AppColors.PRIMARY_COLOR,
      ),
      onPressed: _onRefresh,
    );
  }
}
