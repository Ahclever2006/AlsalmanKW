import 'package:alsalman_app/res/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/topic_type.dart';
import '../../../../core/utils/navigator_helper.dart';
import '../../features/account_tab/presentation/pages/topic_page.dart';
import '../../features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

class MyCheckboxListTile extends StatefulWidget {
  final Function callback;

  const MyCheckboxListTile({Key? key, required this.callback})
      : super(key: key);

  @override
  State<MyCheckboxListTile> createState() => _MyCheckboxListTileState();
}

class _MyCheckboxListTileState extends State<MyCheckboxListTile> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Theme(
          data: ThemeData(
              checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.PRIMARY_COLOR_LIGHT;
              } else
                return AppColors.PRIMARY_COLOR_DARK;
            }),
            checkColor: MaterialStateProperty.all(AppColors.GREY_BORDER_COLOR),
          )),
          child: Checkbox(
              value: value,
              onChanged: (bool? v) {
                value = v ?? false;
                setState(() {});
                widget.callback(value);
              }),
        ),
        _buildLinkText(context),
      ],
    );
  }

  Widget _buildLinkText(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Expanded(
          child: RichText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: TextSpan(
                style: const TextStyle(
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: 'by_sign_up'.tr(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.0, color: AppColors.PRIMARY_COLOR_DARK),
                  ),
                  TextSpan(
                    text: 'terms_of_use'.tr(),
                    style: const TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => NavigatorHelper.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return TopicPage(id: TopicType.Terms.value);
                          })),
                  ),
                  TextSpan(
                    text: 'and'.tr(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.0, color: AppColors.PRIMARY_COLOR_DARK),
                  ),
                  TextSpan(
                    text: 'privacy_policy'.tr(),
                    style: const TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => NavigatorHelper.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return TopicPage(id: TopicType.Privacy.value);
                          })),
                  ),
                ],
              )),
        );
      },
    );
  }
}
