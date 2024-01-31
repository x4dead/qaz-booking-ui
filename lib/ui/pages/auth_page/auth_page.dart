import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_button.dart';
import 'package:qaz_booking_ui/ui/widgets/floating_label_text_field.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: CustomAppBar(leading: (
          null,
          () => context.go('/splash'),
        )),
      ),
      body: Padding(
        padding: kPH20,
        child: Column(
          children: [
            kSBH45,
            FloatingLabelTextField(
              controller: emailController,
              floatingLabelText: 'Эл. почта',
              hintText: 'Адрес эл. почты',
            ),
            kSBH25,
            Row(
              children: [
                Flexible(
                  child: FloatingLabelTextField(
                    textAlign: TextAlign.center,
                    controller: codeController,
                    floatingLabelText: 'Код',
                    hintText: '0000',
                  ),
                ),
                kSBW15,
                const CustomButton(buttonText: 'Отправить'),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: kPH20,
              child: CustomButton(buttonText: 'Далее'),
            ),
            kSBH100,
          ],
        ),
      ),
    );
  }
}
