import 'package:alsalman_app/core/utils/media_query_values.dart';
import 'package:alsalman_app/shared_widgets/stateless/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class GIFNetworkWidget extends StatefulWidget {
  const GIFNetworkWidget({
    required this.gifUrl,
    super.key,
  });

  final String gifUrl;
  @override
  State<GIFNetworkWidget> createState() => _GIFNetworkWidgetState();
}

class _GIFNetworkWidgetState extends State<GIFNetworkWidget> with TickerProviderStateMixin {
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
    return Gif(
      image: NetworkImage(widget.gifUrl),
      controller: _controller,
      autostart: Autostart.loop,
      placeholder: (context) => Padding(
        padding: EdgeInsets.all(context.width * 0.25),
        child: const CustomLoading(),
      ),
      onFetchCompleted: () {
        _controller.reset();
        _controller.forward();
      },
    );
  }
}
