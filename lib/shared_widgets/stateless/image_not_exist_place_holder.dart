import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ImageNotExistPlaceHolder extends StatelessWidget {
  const ImageNotExistPlaceHolder({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        'lib/res/assets/app_logo.svg',
        width: width,
        height: height,
      ),
    );
  }
}
