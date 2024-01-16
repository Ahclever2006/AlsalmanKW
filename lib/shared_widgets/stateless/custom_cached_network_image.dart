import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../res/style/app_colors.dart';
import 'image_not_exist_place_holder.dart';

enum ImageMode {
  Crop,
  Pad,
  Stretch,
  Carve,
  Max,
  ByWidth,
  ByHeight;

  @override
  String toString() => name;
}

enum ScaleMode {
  Down,
  Both,
  Canvas;

  @override
  String toString() => name;
}

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required String? imageUrl,
    BoxFit? fit,
    bool useOldImageOnUrlChange = false,
    BorderRadius borderRadius = BorderRadius.zero,
    Widget Function(BuildContext context, String url)? placeholder,
    Widget Function(BuildContext? context, String? url, dynamic error)?
        errorWidgetCallBack,
    Widget? errorWidget,
    double? width,
    double? height,
    int? urlWidth,
    int? urlHeight,
    ImageMode? imageMode = ImageMode.Crop,
    ScaleMode? scaleMode = ScaleMode.Both,
    Map<String, String>? httpHeaders,
  })  : _imageUrl = imageUrl,
        _fit = fit,
        _useOldImageOnUrlChange = useOldImageOnUrlChange,
        _borderRadius = borderRadius,
        _placeholder = placeholder,
        _errorWidgetCallBack = errorWidgetCallBack,
        _errorWidget = errorWidget,
        _width = width,
        _height = height,
        _urlWidth = urlWidth,
        _urlHeight = urlHeight,
        _imageMode = imageMode,
        _scaleMode = scaleMode,
        _httpHeaders = httpHeaders,
        super(key: key);

  final String? _imageUrl;
  final BoxFit? _fit;
  final bool _useOldImageOnUrlChange;
  final BorderRadius _borderRadius;
  final Widget Function(BuildContext context, String url)? _placeholder;
  final Widget Function(BuildContext? context, String? url, dynamic error)?
      _errorWidgetCallBack;
  final Widget? _errorWidget;
  final double? _width;
  final double? _height;
  final int? _urlWidth;
  final int? _urlHeight;
  final ImageMode? _imageMode;
  final ScaleMode? _scaleMode;
  final Map<String, String>? _httpHeaders;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: _imageUrl?.isNotEmpty == true
          ? CachedNetworkImage(
              httpHeaders: _httpHeaders,
              imageUrl: _createImageUrl(_imageUrl!),
              fit: _fit,
              width: _width,
              height: _height,
              useOldImageOnUrlChange: _useOldImageOnUrlChange,
              placeholder: _placeholder ?? _buildDefaultPlaceholderClosure(),
              errorWidget: (_errorWidget == null
                      ? null
                      : (_, __, ___) => _errorWidget!) ??
                  _errorWidgetCallBack ??
                  _buildDefaultErrorWidgetClosure(),
            )
          : _errorWidget ??
              ImageNotExistPlaceHolder(width: _width, height: _height),
    );
  }

  Widget Function(BuildContext, String) _buildDefaultPlaceholderClosure() {
    return (_, __) => Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          child: const CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(AppColors.PRIMARY_COLOR),
          ),
        );
  }

  Widget Function(BuildContext, String, dynamic)
      _buildDefaultErrorWidgetClosure() {
    return (_, __, ___) =>
        ImageNotExistPlaceHolder(width: _width, height: _height);
  }

  String _createImageUrl(String imageUrl) {
    var queries = <String>[];
    if (_urlWidth != null && _urlHeight != null)
      queries = <String>[
        if (_urlWidth != null) 'w=$_urlWidth',
        if (_urlHeight != null) 'h=$_urlHeight',
        if (_scaleMode != null) 'scale=$_scaleMode',
        if (_imageMode != null) 'mode=$_imageMode',
      ];

    return queries.isEmpty ? imageUrl : '$imageUrl?${queries.join('&')}';
  }
}
