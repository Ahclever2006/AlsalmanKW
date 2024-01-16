import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

import '../../core/exceptions/redundant_request_exception.dart';

void showSnackBar(BuildContext context,
    {required dynamic message,
    Widget? action,
    int duration = 4,
    EdgeInsetsGeometry? margin =
        const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0)}) {
  if (message is RedundantRequestException || message.toString().length > 100)
    return log(message.toString());

  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  if (scaffoldMessenger == null) return;

  scaffoldMessenger.clearSnackBars();

  message = message.toString();

  final snackBarDuration = Duration(seconds: duration);

  final snackBar = SnackBar(
      duration: snackBarDuration,
      margin: margin,
      behavior: SnackBarBehavior.floating,
      content: Directionality(
        textDirection: context.locale == const Locale('en')
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  scaffoldMessenger.clearSnackBars();
                },
                child: Text(
                  (message as String).tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            if (action != null) action,
          ],
        ),
      ));

  scaffoldMessenger.showSnackBar(snackBar);
}
