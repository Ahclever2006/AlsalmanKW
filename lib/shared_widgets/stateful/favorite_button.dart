import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/type_defs.dart';
import '../../res/style/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required FutureCallback<bool> onFavTap,
    bool? initial,
    Color? color,
  })  : _initial = initial ?? false,
        _onFavTap = onFavTap,
        super(key: key);

  final bool _initial;
  final FutureCallback<bool> _onFavTap;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;
  bool _isLoading = false;

  @override
  void initState() {
    _isFavorite = widget._initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: SvgPicture.asset(
          _isFavorite
              ? 'lib/res/assets/heart_fill_icon.svg'
              : 'lib/res/assets/heart_icon.svg',
          color: _isFavorite ? null : AppColors.PRIMARY_COLOR,
        ),
      ),
      onTap: _isLoading
          ? () {}
          : () {
              _isFavorite = !_isFavorite;
              final futureOf = widget._onFavTap();
              if (futureOf is Future) {
                _startLoading();
                (futureOf as Future)
                    .then(
                      (success) => setState(() {
                        if (!success) _isFavorite = !_isFavorite;
                      }),
                    )
                    .whenComplete(_stopLoading);
              }
            },
    );
  }

  void _startLoading() {
    _isLoading = true;
    if (mounted) setState(() {});
  }

  void _stopLoading() {
    _isLoading = false;
    if (mounted) setState(() {});
  }
}
