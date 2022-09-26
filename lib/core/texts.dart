import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_movie_flutter/core/values/app_colors.dart';

import 'dimens.dart';

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

TextStyle primaryTextStyle =
    GoogleFonts.montserrat(color: AppColors.colorPrimary);
TextStyle greenTextStyle = GoogleFonts.montserrat(color: AppColors.colorAccent);
TextStyle blackTextStyle =
    GoogleFonts.montserrat(color: Colors.black);
TextStyle whiteTextStyle =
    GoogleFonts.montserrat(color: AppColors.colorWhite);
TextStyle greyTextStyle =
    GoogleFonts.montserrat(color: AppColors.lightGreyColor);
TextStyle errorTextStyle = GoogleFonts.montserrat(
  color: AppColors.errorColor,
  fontSize: smallText,
);

TextStyle blackBoldTextStyle =
GoogleFonts.montserrat(color: AppColors.colorBlack, fontWeight: FontWeight.w900);

TextStyle blackSemiBoldTextStyle =
GoogleFonts.montserrat(color: AppColors.colorBlack, fontWeight: FontWeight.w600);

TextStyle primarySemiBoldTextStyle =
GoogleFonts.montserrat(color: AppColors.colorPrimary, fontWeight: FontWeight.w600);

TextStyle primaryBoldTextStyle =
GoogleFonts.montserrat(color: AppColors.colorPrimary, fontWeight: FontWeight.w900);


TextStyle halfBlackTextStyle =
    GoogleFonts.montserrat(color: AppColors.textColorGreyDark);

TextStyle hintTextStyle = GoogleFonts.montserrat(
  color: AppColors.lightGreyColor,
  fontSize: largeText,
  fontWeight: regular,
);

TextStyle titleTextStyle = GoogleFonts.baloo2(
  color: AppColors.colorBlack,
  fontWeight: bold,
);

TextStyle poppinsRegular = GoogleFonts.poppins(
  fontWeight: regular,
);
TextStyle poppinsSemiBold = GoogleFonts.poppins(
  fontWeight: semiBold,
);

TextStyle montserratBold700 =
GoogleFonts.montserrat(fontWeight: FontWeight.w700);

