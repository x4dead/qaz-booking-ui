import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/media_query.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          context.go('/auth');
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.color00204A,
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset(AppImages.circle),
                          SvgPicture.asset(AppImages.halfCircle),
                        ],
                      ),
                      SvgPicture.asset(AppImages.mountains),
                    ],
                  ),
                  const SizedBox(height: 31.53),
                  SvgPicture.asset(AppImages.qazBooking),
                  kSBH10,
                  SvgPicture.asset(AppImages.yourJourney),
                ],
              )),
            ),
            Positioned(
              top: -10,
              child: Opacity(
                opacity: 0.25,
                child: Container(
                  width: context.width,
                  height: context.height + 10,
                  decoration: const BoxDecoration(
                      gradient: AppColors.gradienRadialSplash),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
