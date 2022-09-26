import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_movie_flutter/core/dimens.dart';
import 'package:new_movie_flutter/core/texts.dart';
import 'package:new_movie_flutter/core/values/app_colors.dart';
import 'package:new_movie_flutter/core/values/text_styles.dart';

import '../../r.dart';

class StatusDialog extends StatelessWidget {
  final String title;
  final String desc;
  final String? textButton;
  final StatusType? status;
  final Function()? onPressed;

  const StatusDialog({
    Key? key,
    required this.title,
    required this.desc,
    this.textButton,
    this.status = StatusType.success,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonConfirm() {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 35.h,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.colorPrimary,
            ),
            onPressed: onPressed ??
                () {
                  Navigator.pop(context);
                },
            child: Container(
              constraints: BoxConstraints(
                minWidth: 80.w,
              ),
              child: Text(
                textButton ?? 'OK',
                textAlign: TextAlign.center,
                style: whiteText16.copyWith(fontWeight: semiBold),
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Wrap(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 35.h,
              bottom: 15.h,
            ),
            padding: EdgeInsets.only(
              left: largeHorizontal,
              right: largeHorizontal,
              bottom: xtraLargeVertical,
              top: 70.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColors.colorWhite,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: titleTextStyle.copyWith(
                    fontSize: xtraLargeText,
                  ),
                ),
                SizedBox(height: smallVertical),
                Text(
                  desc,
                  style: blackTextStyle.copyWith(
                    fontSize: mediumText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: largeHorizontal),
        child: Center(
          child: Stack(
            children: [
              content(),
              buttonConfirm(),
            ],
          ),
        ),
      ),
    );
  }
}

enum StatusType { success, error, info }
