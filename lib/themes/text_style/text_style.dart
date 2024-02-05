import 'package:flutter/cupertino.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

abstract class AppTextStyle {
  static const TextStyle w500s18 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const TextStyle w600s9 = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
  );
  static TextStyle w600s24 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 29.0.toFigmaHeight(24));
// Font: Gilroy
// Font weight: 600
// Font size: 9pxpx
// Row height: 11px
// Letter spacing: 0px
// Align: Align center

// color: var(--Primary-Black, #1B1D24);
// text-align: center;
// font-family: Gilroy;
// font-size: 18px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static TextStyle w500s14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 17.0.toFigmaHeight(14));
// color: var(--Gradations-gray-Dark-Gray, #375165);
// text-align: center;
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static TextStyle w500s16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 19.0.toFigmaHeight(16));

// color: var(--Gradations-gray-Gray, #B6CCDD);
// text-align: center;
// font-family: Gilroy;
// font-size: 16px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static const TextStyle w500s12 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
// color: var(--Gradations-gray-Dark-Gray, #375165);
// font-family: Gilroy;
// font-size: 12px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Primary-White, #FFF);
// text-align: center;
// leading-trim: both;
// text-edge: cap;
// font-variant-numeric: lining-nums tabular-nums;
// font-family: Gilroy;
// font-size: 12px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static const TextStyle w500s10 =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
// color: var(--Gradations-gray-Dark-Gray, #375165);
// font-family: Gilroy;
// font-size: 10px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static TextStyle w500s18Ellipsis = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      height: 13.0.toFigmaHeight(18));
// overflow: hidden;
// color: var(--Primary-Black, #1B1D24);
// leading-trim: both;
// text-edge: cap;
// text-overflow: ellipsis;
// font-family: Gilroy;
// font-size: 18px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Gradations-gray-Dark-Gray, #375165);
// leading-trim: both;
// text-edge: cap;
// font-variant-numeric: lining-nums tabular-nums;
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Gradations-gray-Dark-Gray, #375165);
// leading-trim: both;
// text-edge: cap;
// font-variant-numeric: lining-nums tabular-nums;
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Primary-Black, #1B1D24);
// leading-trim: both;
// text-edge: cap;
// font-family: Gilroy;
// font-size: 18px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Primary-White, #FFF);
// text-align: center;
// font-family: Gilroy;
// font-size: 12px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Primary-Black, #1B1D24);
// font-variant-numeric: lining-nums tabular-nums;
// font-family: Gilroy;
// font-size: 16px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static const TextStyle w400s16 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
// color: var(--Primary-Black, #1B1D24);
// text-align: center;
// font-family: Gilroy;
// font-size: 16px;
// font-style: normal;
// font-weight: 400;
// line-height: normal;

  static const TextStyle w400s14 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
// color: var(--Primary-Black, #1B1D24);
// text-align: center;
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 400;
// line-height: normal;

// color: var(--Primary-Orange, #F57A21);
// text-align: center;
// font-family: Gilroy;
// font-size: 16px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static const TextStyle w500s20 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
// color: var(--Primary-Black, #1B1D24);
// font-family: Gilroy;
// font-size: 20px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Gradations-gray-Dark-Gray, #375165);
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// overflow: hidden;
// color: var(--Gradations-gray-Dark-Gray, #375165);
// text-align: right;
// font-variant-numeric: lining-nums tabular-nums;
// text-overflow: ellipsis;
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static const TextStyle w600s20 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
// color: var(--Primary-Black, #000715);
// font-family: Gilroy;
// font-size: 20px;
// font-style: normal;
// font-weight: 600;
// line-height: normal;

// color: var(--Primary-Black, #000715);
// font-family: Gilroy;
// font-size: 14px;
// font-style: normal;
// font-weight: 400;
// line-height: normal;

// color: var(--Primary-Blue, #228AEB);
// text-align: center;
// font-family: Gilroy;
// font-size: 16px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

// color: var(--Primary-Black, #1B1D24);
// text-align: center;
// font-family: Gilroy;
// font-size: 16px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;

  static TextStyle w400s15SFProDisplay = TextStyle(
    height: 24.0.toFigmaHeight(15),
    letterSpacing: 0.3,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.colorDarkGray,
    fontFamily: 'SF Pro Display',
  );
// color: var(--Gradations-gray-Dark-Gray, #375165);
// text-align: center;
// font-family: "SF Pro Display";
// font-size: 15px;
// font-style: normal;
// font-weight: 400;
// line-height: 24px; /* 160% */
// letter-spacing: -0.3px;

// color: var(--Primary-Black, #1B1D24);
// font-family: Gilroy;
// font-size: 18px;
// font-style: normal;
// font-weight: 500;
// line-height: normal;
}
