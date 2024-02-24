import 'package:flutter/cupertino.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

class DateViewCard extends StatelessWidget {
  const DateViewCard(
      {super.key,
      required this.bgColor,
      required this.weekDay,
      required this.textColor,
      required this.day});
  final Color bgColor;
  final String weekDay;
  final Color textColor;
  final String day;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
          borderRadius: allCircularRadius12, color: bgColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weekDay.toUpperCase(),
            style: AppTextStyle.w600s9.copyWith(
              color: textColor,
              height: 6.0.toFigmaHeight(9),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            day,
            style: AppTextStyle.w500s12.copyWith(
              color: textColor,
              height: 8.0.toFigmaHeight(12),
            ),
          ),
        ],
      ),
    );
  }
}
