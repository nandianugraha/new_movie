import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/dimens.dart';
import 'package:new_movie_flutter/core/values/app_colors.dart';
import 'package:new_movie_flutter/widget/button_custom.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String? positifText;
  final String? negatifText;
  final Function()? onPressed;
  final Function()? negativePressed;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.description,
    this.positifText,
    this.negatifText,
    this.onPressed,
    this.negativePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: defaultHorizontal),
          padding: EdgeInsets.symmetric(horizontal: smallHorizontal),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: largeVertical),
              Text(title, style: const TextStyle(color: Colors.black)),
              SizedBox(height: xtraSmallVertical),
              Text(
                description,
                style: const TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: mediumVertical),
              Row(
                children: [
                  Expanded(
                    child: ButtonCustom(
                      height: 40.h,
                      title: negatifText ?? "NO",
                      color: AppColors.textColorGreyLight,
                      textColor: AppColors.colorPrimary,
                      onPressed: negativePressed ??
                          () {
                            Get.back();
                          },
                    ),
                  ),
                  SizedBox(width: xtraSmallHorizontal),
                  Expanded(
                    child: ButtonCustom(
                      height: 40.h,
                      title: positifText ?? "YES",
                      color: AppColors.colorPrimary,
                      textColor: AppColors.colorWhite,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediumVertical),
            ],
          ),
        ),
      ),
    );
  }
}
