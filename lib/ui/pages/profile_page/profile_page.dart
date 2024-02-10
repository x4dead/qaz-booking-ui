import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_button.dart';
import 'package:qaz_booking_ui/ui/widgets/drawer_menu.dart';
import 'package:qaz_booking_ui/ui/widgets/floating_label_text_field.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';
import 'package:qaz_booking_ui/utils/extentions/figma_height.dart';
import 'package:qaz_booking_ui/utils/extentions/media_query.dart';
import 'package:qaz_booking_ui/utils/resources/app_images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.routeState});
  final GoRouterState? routeState;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final globalKey = GlobalKey<ScaffoldState>();

class _ProfilePageState extends State<ProfilePage> {
  final firstLastName = TextEditingController(text: 'Пётр Жаринов');
  final phoneNumber = TextEditingController(text: '+7 (777) 305-88-80');
  final email = TextEditingController(text: 'sdfsdgdaa@gmail.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppBar(
        title: 'Профиль',
        leading: (
          SvgPicture.asset(AppImages.menu),
          () => globalKey.currentState?.openDrawer(),
        ),
      ),
      drawer: DrawerMenu(routeState: widget.routeState),
      body: Column(
        children: [
          Padding(
            padding: kPAll20,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.colorBlue,
                  radius: 44.5,
                  child: Center(
                    child: Text(
                      'ПЖ',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.w600s24
                          .copyWith(color: AppColors.colorWhite),
                    ),
                  ),
                ),
                kSBW12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Пётр Жаринов',
                      style: AppTextStyle.w600s20.copyWith(
                          height: 20.0.toFigmaHeight(20),
                          color: AppColors.colorBlack),
                    ),
                    kSBH5,
                    Text(
                      '+7 (777) 305-88-80',
                      style: AppTextStyle.w400s14.copyWith(
                          height: 17.0.toFigmaHeight(14),
                          color: AppColors.colorBlack),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kSBH25,
          Flexible(
            child: ListView(
              padding: kPH20V12,
              children: [
                FloatingLabelTextField(
                  controller: firstLastName,
                  floatingLabelText: 'Имя Фамилия',
                ),
                kSBH25,
                FloatingLabelTextField(
                  controller: phoneNumber,
                  floatingLabelText: 'Телефон',
                ),
                kSBH25,
                FloatingLabelTextField(
                  controller: email,
                  floatingLabelText: 'Эл. почта',
                ),
              ],
            ),
          ),
          kSBH10,

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                  isOutlinedButton: true,
                  textColor: AppColors.colorBlue,
                  buttonText: "Выйти из аккаунта",
                  onTap: () {
                    context.go('/splash');
                  },
                  bgColor: AppColors.colorTransparent,
                  borderColor: AppColors.colorBlue),
            ),
          ),

          ///Адаптивный зазор если высота экрана меньше 630
          ///зазор будет уменьшаться, вместо статичного зазор
          SizedBox(
            height: context.height <= 700
                ? context.height * 0.2142857142857143
                : 150,
          ),
          // kSBH50,
          // kSBH100,
        ],
      ),
    );
  }
}
