import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';
import '../stateless/custom_cached_network_image.dart';

Future<dynamic> openFullImage({
  required BuildContext context,
  required List<String?> images,
  required int index,
}) {
  return showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) =>
        _interActiveViewCustomWidget(images: images, index: index),
  );
}

class _interActiveViewCustomWidget extends StatefulWidget {
  const _interActiveViewCustomWidget({
    required this.images,
    required this.index,
    Key? key,
  }) : super(key: key);

  final List<String?> images;
  final int index;

  @override
  State<_interActiveViewCustomWidget> createState() =>
      _interActiveViewCustomWidgetState();
}

class _interActiveViewCustomWidgetState
    extends State<_interActiveViewCustomWidget> {
  late final PageController _pageController;
  late final TransformationController _transformationController;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: NavigatorHelper.of(context).pop,
      child: Material(
        color: Colors.transparent,
        child: PageView(
          onPageChanged: (_) =>
              _transformationController.value = Matrix4.identity(),
          controller: _pageController,
          children: widget.images.map((e) {
            return _buildImageItem(
              image: e!,
              pageController: _pageController,
              tapDownDetails: _doubleTapDetails,
              transformationController: _transformationController,
            );
          }).toList(),
        ),
      ),
    );
  }
}

InteractiveViewer _buildImageItem({
  required String image,
  required TransformationController transformationController,
  required PageController pageController,
  TapDownDetails? tapDownDetails,
}) {
  return InteractiveViewer(
    transformationController: transformationController,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        onDoubleTapDown: (details) {
          _handleDoubleTapDown(details, tapDownDetails);
        },
        onDoubleTap: () {
          _handleDoubleTap(transformationController, tapDownDetails);
        },
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: CustomCachedNetworkImage(
              imageUrl: image,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
    ),
  );
}

void _handleDoubleTapDown(
        TapDownDetails details, TapDownDetails? doubleTapDetails) =>
    doubleTapDetails = details;

void _handleDoubleTap(TransformationController transformationController,
    TapDownDetails? doubleTapDetails) {
  if (transformationController.value != Matrix4.identity())
    transformationController.value = Matrix4.identity();
  else {
    if (doubleTapDetails == null) return;
    final position = doubleTapDetails.localPosition;

    transformationController.value = Matrix4.identity()
      ..translate(-position.dx * 2, -position.dy * 2)
      ..scale(3.0);
  }
}
