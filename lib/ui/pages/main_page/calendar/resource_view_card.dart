import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qaz_booking_ui/model/object_to_book_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class ResourceViewCard extends StatelessWidget {
  const ResourceViewCard({super.key, required this.resource});
  final ObjectToBook resource;

  @override
  Widget build(BuildContext context) {
    final resourceStyle = AppTextStyle.w500s10.copyWith(
        height: 12.0.toFigmaHeight(10), color: AppColors.colorDarkGray);
    return Container(
      height: 92,
      constraints: const BoxConstraints(minHeight: 92),
      decoration: const BoxDecoration(
          color: AppColors.colorWhite, border: bottomBorder),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12)
          .copyWith(bottom: 11),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            AppImages.bed,
            colorFilter: const ColorFilter.mode(
                AppColors.colorDarkGray, BlendMode.srcIn),
          ),
          kSBH4,
          Text(resource.objectName!, style: resourceStyle),
          kSBH2,
          Text(resource.objectType!, style: resourceStyle),
          kSBH2,
          Text("${resource.roomsCount!} персоны",
              style: resourceStyle, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
