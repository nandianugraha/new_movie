// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:new_movie_flutter/core/dimens.dart';
import 'package:new_movie_flutter/core/texts.dart';
import 'package:new_movie_flutter/core/values/app_colors.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final bool active;
  final EdgeInsets margin;
  Function()? onPressed;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? elevation;

  ButtonCustom(
      {Key? key,
      required this.title,
      this.active = true,
      this.margin = EdgeInsets.zero,
      required this.onPressed,
      this.height,
      this.color = AppColors.colorPrimary,
      this.textColor,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle() {
      if (active) {
        return ElevatedButton.styleFrom(primary: color, elevation: elevation);
      } else {
        return ElevatedButton.styleFrom(primary: Colors.grey[350]);
      }
    }

    TextStyle textStyle() {
      if (active) {
        return whiteTextStyle.copyWith(
          fontSize: mediumText,
          fontWeight: bold,
          color: textColor,
        );
      } else {
        return whiteTextStyle.copyWith(
          fontSize: mediumText,
          fontWeight: bold,
        );
      }
    }

    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: active ? onPressed : null,
        style: buttonStyle(),
        child: SizedBox(
          height: height ?? buttonHeight,
          child: Center(
            child: Text(
              title,
              style: textStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
