import 'package:admin_panel_so/constant/app_color.dart';
import 'package:admin_panel_so/constant/media_qury.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double contentPadding;
  final double borderRadius;
  final Color borderColor;
  final Color focusBorderColor;
  final Color errorBorderColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final bool? psdObs;
  final String? obscuringCharacter;
  final Widget? suffix;
  final double? margin;
  final String label;
  final bool? enabled;
  final bool? filled;
  final Color? fillColor;
  final bool isLabel;
  final int? maxLine;
  final IconData? prefixIcon;
  final Iterable<String>? autofillHints;
  final TapRegionCallback? onTapOutside;
  final TextInputAction? textInputAction;

  const AppTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.borderColor,
      required this.focusBorderColor,
      required this.label,
      required this.borderRadius,
      this.obscuringCharacter,
      this.errorBorderColor = appSecondary,
      this.contentPadding = 10,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.psdObs,
      this.margin,
      this.suffix,
      this.autofillHints,
      this.onTapOutside,
      this.textInputAction,
      this.enabled,
      this.filled = false,
      this.fillColor,
      required this.isLabel,
      this.prefixIcon,
      this.maxLine = 1,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: margin ?? mediaQueryHeight(context) * 0.01),
      child: TextFormField(
        onChanged: onChange,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofillHints: autofillHints,
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: psdObs ?? false,
        obscuringCharacter: obscuringCharacter ?? '•',
        decoration: InputDecoration(
            hintText: hint,
            label: isLabel == true ? Text(label) : null,
            contentPadding: EdgeInsets.all(contentPadding),
            border: InputBorder.none,
            suffixIcon: suffix,
            suffixIconColor: onPrimary,
            filled: filled,
            fillColor: fillColor,
            prefixIcon: Icon(prefixIcon),
            enabledBorder: _outlineInputBorder(borderRadius, borderColor),
            focusedBorder: _outlineInputBorder(borderRadius, focusBorderColor),
            errorBorder: _outlineInputBorder(borderRadius, errorBorderColor),
            focusedErrorBorder:
                _outlineInputBorder(borderRadius, errorBorderColor),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius),
            )),
        validator: validator,
        maxLines: maxLine,
        textInputAction: textInputAction,
        onTapOutside: onTapOutside ?? (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder(borderRadius, borderColor) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor));
}
