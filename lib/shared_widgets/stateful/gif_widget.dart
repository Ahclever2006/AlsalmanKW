import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class GIFWidget extends StatefulWidget {
  const GIFWidget({
    required this.gifUrl,
    super.key,
  });

  final String gifUrl;
  @override
  State<GIFWidget> createState() => _GIFWidgetState();
}

class _GIFWidgetState extends State<GIFWidget> with TickerProviderStateMixin {
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
      placeholder: (context) => const Text('Loading...'),
      onFetchCompleted: () {
        _controller.reset();
        _controller.forward();
      },
    );
  }
}
