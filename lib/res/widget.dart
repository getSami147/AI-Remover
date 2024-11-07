import 'package:ai_object_remover/view/onboardingScreen/SelectPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_object_remover/res/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Constant.dart';


import 'package:flutter/material.dart';

// CustomAppBar .....................................>>>
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? action;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return AppBar(
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      title: Stack(
        alignment: Alignment.center,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "AI",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                TextSpan(
                  text: "Remover",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        action ??
            SizedBox(
              width: size.width * .2,
              height: size.height * .04,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(0.4),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                child: text(
                  'Get Pro',
                  fontSize: 14.0,
                  color: Colors.white,
                  isLongText: true,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: () {
                  // Add your action here
                },
              ),
            ).paddingRight(spacing_twinty),
      ],
      backgroundColor: bgColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Elevated button .....................................>>>
// ignore: must_be_immutable
class elevatedButton extends StatelessWidget {
  VoidCallback? onPress;
  var isStroked = false;
  double? elevation;
  Widget? child;
  ValueChanged? onFocusChanged;
  Color backgroundColor;
  Color bodersideColor;
  var height;
  var width;
  var borderRadius;
  var loading;

  elevatedButton(
    BuildContext context, {
    Key? key,
    this.loading = false,
    var this.isStroked = false,
    this.onFocusChanged,
    required var this.onPress,
    this.elevation,
    var this.child,
    var this.backgroundColor = primaryButtonColor,
    var this.bodersideColor = primaryButtonColor,
    var this.borderRadius = 30.0,
    var this.height = 60.0,
    var this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          onFocusChange: onFocusChanged,
          onPressed: onPress,
          style: isStroked
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder())
              : ElevatedButton.styleFrom(
                  elevation: elevation,
                  side: BorderSide(color: bodersideColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  backgroundColor: backgroundColor,
                ),
          child: loading
              ? const CircularProgressIndicator(
                  color: color_white,
                  strokeWidth: 2,
                )
              : child),
    );
  }
}

// Elevated button .....................................>>>Finished
// ignore: must_be_immutable

class GradientButton extends StatelessWidget {
  bool? loading;

  Widget? child;
  Gradient? gradientColors;
  Color? buttonbgColor;
  var borderRadius;
  var height, width;
  VoidCallback? onPressed;
  Color? disabledBackgroundColor;

  GradientButton(
      {required this.child,
      this.loading,
      this.disabledBackgroundColor,
      this.width = double.infinity,
      required this.onPressed,
      this.height = 50.0,
      this.buttonbgColor = Colors.transparent,
      this.borderRadius = 10.0,
      this.gradientColors = const LinearGradient(
        colors: [
          Colors.pink,
          Colors.blue,
        ],
      ),
      super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradientColors,
            boxShadow: const [
              BoxShadow(
                color: Colors.pink,
                offset: Offset(-2, 0),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.blue,
                offset: Offset(2, 0),
                blurRadius: 10,
              ),
            ]),
        child: AnimatedContainer(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: bgColor),
          duration: const Duration(milliseconds: 500),
          child: loading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final String hint;
  final List<DropdownMenuItem<String>>? items;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  // final TextStyle textStyle;
  // final EdgeInsets padding;
  final String? value;

  const CustomDropdownButton({
    required this.hint,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    // required this.textStyle,
    // required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 24,
                offset: const Offset(0, 4),
                spreadRadius: 0,
                color: const Color(0xff000000).withOpacity(.1))
          ]),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: InputBorder.none,
        ),
        hint: text(hint),
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

// Text widget .....................................>>>Start
Widget text(String? text,
    {var fontSize = textSizeMedium,
    Color? color,
    bool isgoogleFonts = false,
    var fontFamily = 'Poppins',
    var isCentered = false,
    var maxLine = 1,
    TextOverflow? overflow,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
    var fontWeight = FontWeight.w400}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: overflow,
    style: isgoogleFonts
        ? GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? Colors.white,
            height: 1.5,
            letterSpacing: latterSpacing,
            decoration:
                lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
          )
        : TextStyle(
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color ?? Colors.white,
            letterSpacing: latterSpacing,
            decoration:
                lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
          ),
  );
}

class CustomTextFormField extends StatelessWidget {
  final VoidCallback? onPressed;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;

  final EdgeInsetsGeometry? contantpadding;
  final String? hintText;
  final String? labelText;
  final Color filledColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BorderSide? borderSide;
  final bool isPassword;
  final bool isSecure;
  final double labelFontSize;
  final double fontSize;
  final Color textColor;
  final String? fontFamily;
  final String? text;
  final double suffixWidth;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  CustomTextFormField(
    BuildContext context, {
    Key? key,
    this.focusNode,
    this.onFieldSubmitted,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.minLines,
    this.onChanged,
    this.contantpadding =
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    this.onPressed,
    this.suffixWidth = 50.0,
    this.hintText,
    this.labelText,
    this.filledColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.borderSide,
    this.fontFamily,
    this.fontSize = 14.0,
    this.labelFontSize = 18.0,
    this.isPassword = false,
    this.isSecure = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.text,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 4),
            spreadRadius: 0,
            color: const Color(0xff000000).withOpacity(.1),
          ),
        ],
      ),
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        focusNode: focusNode,
        minLines: minLines,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        obscureText: obscureText,
        onTap: onPressed,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: contantpadding,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            maxHeight: 30,
            maxWidth: suffixWidth,
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color(0xFFF1F1F1).withOpacity(.30)),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontFamily: "FutuBd",
            color: Colors.white,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: labelFontSize,
            fontFamily: "futurbci",
            color: Colors.white,
          ),
          isDense: true,
        ),
      ),
    );
  }
}

// Text TextFromFeild end...........................................>>>

Widget formField(context, hint,
    {isEnabled,
    isDark = false,
    isDummy = false,
    controller,
    showBorder = false,
    changeHintColor = false,
    changeBackground = false,
    isPasswordVisible = false,
    isPassword = false,
    onEditingComplete,
    keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
    onSaved,
    height,
    onChanged,
    textInputAction = TextInputAction.next,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    Widget? suffixIcon,
    Widget? prefixIcon,
    maxLine = 1,
    minLine,
    suffixIconSelector}) {
  return Container(
    height: height,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.9,
    child: TextFormField(
      enabled: isEnabled,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      controller: controller,
      obscureText: isPassword ? isPasswordVisible : false,
      cursorColor: textColorPrimary,
      maxLines: maxLine,
      minLines: minLine,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (arg) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_standard),
            borderSide: changeBackground
                ? showBorder
                    ? const BorderSide(color: primaryColor)
                    : BorderSide.none
                : const BorderSide(color: borderColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_standard),
            borderSide: changeBackground
                ? showBorder
                    ? const BorderSide(color: borderColor)
                    : BorderSide.none
                : const BorderSide(color: borderColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_standard),
            borderSide: changeBackground
                ? showBorder
                    ? const BorderSide(color: borderColor)
                    : BorderSide.none
                : const BorderSide(color: borderColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_standard),
            borderSide: changeBackground
                ? showBorder
                    ? const BorderSide(color: borderColor)
                    : BorderSide.none
                : const BorderSide(color: borderColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_standard),
            borderSide: changeBackground
                ? showBorder
                    ? const BorderSide(color: borderColor)
                    : BorderSide.none
                : const BorderSide(color: borderColor)),
        filled: true,
        fillColor: changeBackground ? Colors.white : edittext_background,
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: textSizeSMedium,
            color: changeHintColor ? textColorPrimary : textcolorSecondary),
        prefixIcon: prefixIcon,
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: suffixIconSelector,
                child: suffixIcon,
              )
            : suffixIcon,
      ),
      style: TextStyle(
          fontSize: textSizeMedium,
          color: isDummy
              ? Colors.transparent
              : isDark == true
                  ? textColorPrimary
                  : textcolorSecondary,
          fontFamily: fontRegular),
    ),
  );
}
