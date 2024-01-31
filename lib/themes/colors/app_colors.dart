import 'package:flutter/material.dart';

abstract class AppColors {
  ///
  static const Color colorBlack = Color(0xff1B1D24);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color color000000 = Color(0xff000000);

  ///
  static const Color colorDarkGray = Color(0xff375165);
  static const Color colorLightGray = Color(0xffF2F6F9);
  static const Color colorGray = Color(0xffB6CCDD);

  ///
  static const Color colorBlue = Color(0xff228AEB);
  static const Color colorSecondaryBlue = Color(0xffADD7FF);

  ///
  static const Color colorGreen = Color(0xff08D698);
  static const Color colorSecondaryGreen = Color(0xff93F9DB);

  ///
  static const Color colorOrange = Color(0xffF57A21);
  static const Color colorSecondaryOrange = Color(0xffFFD6B8);

  ///
  static const Color colorViolet = Color(0xff9F22EB);
  static const Color colorSecondaryViolet = Color(0xffE2B3FF);

  ///
  static const Color color344B53 = Color(0xff344B53);
  static const Color colorB1C8D0 = Color(0xffB1C8D0);
  static const Color color00204A = Color(0xff00204A);
  static const RadialGradient gradienRadialSplash = RadialGradient(
    center: Alignment(3, -0.5),
    focal: Alignment(1.5, -0.5),
    focalRadius: 0.5,
    radius: 3,
    colors: [colorWhite, Color(0x00FFFFFF)],
  );

  static const Color colorTransparent = Colors.transparent;
}
