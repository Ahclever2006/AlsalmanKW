import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../res/style/app_colors.dart';

///`current` is equal to `DateTime.now()` by default!
class CounterDownTimer extends StatefulWidget {
  const CounterDownTimer({
    Key? key,
    DateTime? current,
    required DateTime till,
    EdgeInsets margin = EdgeInsets.zero,
    AlignmentGeometry? alignment,
    required VoidCallback onTimeUp,
  })  : _current = current,
        _till = till,
        _margin = margin,
        _alignment = alignment,
        _onTimeUp = onTimeUp,
        super(key: key);

  final DateTime? _current;
  final DateTime _till;
  final EdgeInsets _margin;
  final AlignmentGeometry? _alignment;
  final VoidCallback _onTimeUp;

  @override
  State<CounterDownTimer> createState() => _CounterDownTimerState();
}

class _CounterDownTimerState extends State<CounterDownTimer> {
  late final Timer _timer;
  late DateTime _current;
  late Duration _timeLeft;
  var _additionSeconds = const Duration();

  @override
  void initState() {
    _current = (widget._current ?? DateTime.now());
    _timeLeft = widget._till.difference(_current);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => mounted
          ? setState(() {
              _additionSeconds += const Duration(seconds: 1);
              final current = _current.add(_additionSeconds);
              _timeLeft = widget._till.difference(current);
              if (_timeUp(_timeLeft)) _stopTimer();
            })
          : () {},
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: widget._margin,
        alignment: widget._alignment,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimeText(_timeLeft.inMinutes.remainder(60)),
            _buildText(' : '),
            _buildTimeText(_timeLeft.inSeconds.remainder(60))
          ],
        ),
      ),
    );
  }

  void _stopTimer() {
    _timer.cancel();
    widget._onTimeUp();
  }

  bool _timeUp(Duration timeLeft) => timeLeft.inSeconds <= 0;

  Widget _buildTimeText(num time) {
    final text = '${time < 10 ? '0' : ''}$time';
    return _buildText(text);
  }

  Text _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.PRIMARY_COLOR,
      ),
    );
  }
}
