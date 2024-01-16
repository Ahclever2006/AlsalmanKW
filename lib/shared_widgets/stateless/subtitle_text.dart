import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:size_helper/size_helper.dart';

///Don't use it with items or cards (inside any lists) because it uses SizeHelper inside it so the O(n) and the best solution here is to use SizeHelper from the outside and pass the result to every item/card by parameters so the big O will be O(1).
class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.isBold = false,
    this.subtractedSize = 0.0,
    this.textDirection,
    this.margin,
    this.color,
    this.fontFamily,
    this.maxLines = 10,
  });

  final String text;
  final bool isBold;
  final double subtractedSize;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final EdgeInsets? margin;
  final Color? color;
  final String? fontFamily;
  final int? maxLines;

  const SubtitleText.small({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: 4.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );
  const SubtitleText.medium({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: 2.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  const SubtitleText.large({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: -6.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  const SubtitleText.extraLarge({
    Key? key,
    required String text,
    bool isBold = false,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    EdgeInsets? margin,
    Color? color,
    String? fontFamily,
    int? maxLines = 10,
  }) : this(
          key: key,
          text: text,
          isBold: isBold,
          subtractedSize: -12.0,
          textAlign: textAlign,
          textDirection: textDirection,
          margin: margin,
          color: color,
          fontFamily: fontFamily,
          maxLines: maxLines,
        );

  @override
  Widget build(BuildContext context) {
    final textStyleBefore = context
        .sizeHelper(
          mobileLarge:
              Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12.0),
          tabletSmall: Theme.of(context).textTheme.bodyText1,
          tabletLarge: Theme.of(context).textTheme.bodyText2,
          desktopSmall:
              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18.0),
        )
        .copyWith(
          color: color,
          fontFamily: fontFamily ?? 'Neo Sans Arabic',
        );

    final textStyleAfter = textStyleBefore.copyWith(
        fontSize: textStyleBefore.fontSize! - subtractedSize);
    Widget child = Text(
      text.tr(),
      softWrap: true,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      textDirection: textDirection,
      style: textStyleAfter,
    );

    if (margin != null) child = Padding(padding: margin!, child: child);

    return child;
  }
}
