import 'package:flutter/cupertino.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/lib/calendar.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({
    super.key,
    required this.calendarAppointmentDetails,
  });
  final CalendarAppointmentDetails calendarAppointmentDetails;
  @override
  Widget build(BuildContext context) {
    final appointment = calendarAppointmentDetails.appointments.first
        // as GuestModel;
        ;
    Color getAppointmentPaymentColor(Color color) => switch (color) {
          AppColors.colorBlue => AppColors.colorSecondaryBlue,
          AppColors.colorOrange => AppColors.colorSecondaryOrange,
          AppColors.colorViolet => AppColors.colorSecondaryViolet,
          _ => AppColors.colorSecondaryGreen
        };
    return Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            color: appointment.color, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appointment.guestFullname!,
                style: AppTextStyle.w500s12.copyWith(
                  color: AppColors.colorWhite,
                  height: 15.0.toFigmaHeight(12),
                )),
            Text(appointment.payment!,
                style: AppTextStyle.w500s12.copyWith(
                    height: 15.0.toFigmaHeight(12),
                    color: getAppointmentPaymentColor(appointment.color!))),
          ],
        ));
  }
}
