import 'package:flutter/cupertino.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/calendar/common/calendar_view_helper.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

class BookedGuestViewCard extends StatelessWidget {
  const BookedGuestViewCard({
    super.key,
    required this.bookedGuest,
    this.borderRadius,
  });
  final GuestModel bookedGuest;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            color: bookedGuest.color,
            borderRadius: borderRadius ?? allCircularRadius12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(bookedGuest.guestFullname!,
                style: AppTextStyle.w500s12.copyWith(
                    color: AppColors.colorWhite,
                    height: 15.0.toFigmaHeight(12),
                    overflow: TextOverflow.ellipsis)),
            Text(bookedGuest.payment!,
                style: AppTextStyle.w500s12.copyWith(
                    height: 15.0.toFigmaHeight(12),
                    color: getBookedGuestPaymentColor(bookedGuest.color!),
                    overflow: TextOverflow.ellipsis)),
          ],
        ));
  }
}
