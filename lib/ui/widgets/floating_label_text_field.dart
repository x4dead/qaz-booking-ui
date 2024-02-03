import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/themes/text_style/text_style.dart';
import 'package:qaz_booking_ui/utils/constants/ui_constants.dart';

class FloatingLabelTextField extends StatefulWidget {
  const FloatingLabelTextField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    required this.floatingLabelText,
    this.inputFormatters,
    this.helperStyle,
    this.floatingLabelStyle,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.suffix,
    this.textStyle,
    this.onEditingComplete,
    this.myFocusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.onSaved,
    this.helperWeight = FontWeight.w400,
    this.focusedColor,
    this.hintStyle,
    this.textAlign,
    this.floatingLabelBgColor = AppColors.colorWhite,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String floatingLabelText;
  final RegExp? inputFormatters;
  final TextStyle? helperStyle;
  final FontWeight? helperWeight;
  final TextStyle? textStyle;
  final TextStyle? floatingLabelStyle;
  final TextStyle? hintStyle;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final Widget? suffix;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final FocusNode? myFocusNode;
  final Color? focusedColor;
  final TextAlign? textAlign;
  final Color? floatingLabelBgColor;
  @override
  State<FloatingLabelTextField> createState() => _FloatingLabelTextFieldState();
}

class _FloatingLabelTextFieldState extends State<FloatingLabelTextField> {
  late List<TextInputFormatter> inputFormatters;

  final isFocused = ValueNotifier<bool>(false);
  late double contentPadding;
  @override
  void initState() {
    super.initState();
    widget.myFocusNode?.addListener(() {
      if (widget.myFocusNode?.hasFocus ?? false) {
        isFocused.value = true;
      } else {
        isFocused.value = false;
      }
    });

    inputFormatters = widget.inputFormatters == null
        ? <TextInputFormatter>[]
        : [FilteringTextInputFormatter.allow(widget.inputFormatters!)];
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            width: 1,
            color: AppColors.colorGray,
            strokeAlign: BorderSide.strokeAlignInside),
        gapPadding: 10);

    ///Использую стек для правильного отображения плавающего текста над hintText
    return ValueListenableBuilder(
        valueListenable: isFocused,
        builder: (context, value, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              TextFormField(
                focusNode: widget.myFocusNode,
                onFieldSubmitted: widget.onFieldSubmitted,
                onSaved: widget.onSaved,
                style: widget.textStyle ??
                    AppTextStyle.w500s16.copyWith(color: AppColors.colorBlack),
                obscureText: widget.obscureText,
                inputFormatters: inputFormatters,
                onChanged: widget.onChanged,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                controller: widget.controller,
                validator: widget.validator,
                onEditingComplete: widget.onEditingComplete,
                cursorWidth: 1,
                textAlign: widget.textAlign ?? TextAlign.start,
                decoration: InputDecoration(
                    // constraints:
                    // const BoxConstraints(maxHeight: 56, minHeight: 56),
                    enabledBorder: border,
                    border: border,
                    focusedBorder: border,
                    focusColor: widget.focusedColor,
                    suffixIcon: widget.suffix,
                    hintText: widget.hintText,
                    contentPadding: kPH20V18Dot5,
                    hintStyle: widget.hintStyle ??
                        AppTextStyle.w500s16
                            .copyWith(color: AppColors.colorGray)),
              ),
              Positioned(
                top: -8,
                left: 22,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 17,
                  color: widget.floatingLabelBgColor!,
                  alignment: Alignment.center,
                  child: Text(
                    widget.floatingLabelText,
                    style: widget.floatingLabelStyle ??
                        AppTextStyle.w500s14
                            .copyWith(color: AppColors.colorDarkGray),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
