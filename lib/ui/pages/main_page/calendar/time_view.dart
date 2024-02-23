import 'package:flutter/cupertino.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

class TimeView extends StatelessWidget {
  const TimeView(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.hour});
  final Color bgColor;

  final Color textColor;
  final String hour;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: bgColor),
      child: Center(
        child: Text(
          hour,
          style: AppTextStyle.w500s12.copyWith(
            color: textColor,
            height: 8.0.toFigmaHeight(12),
          ),
        ),
      ),
    );
  }
}
