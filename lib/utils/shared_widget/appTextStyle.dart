import 'package:flutter/material.dart';

class AppTextStyle extends StatelessWidget {
  final double? marginVer;
  final double? marginHor;
  final String text;
  final int? maxLine;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const AppTextStyle({
    super.key,
    required this.text,
    this.marginVer,
    this.marginHor,
    this.fontWeight,
    this.fontSize,
    this.maxLine,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVer ??0, horizontal: marginHor??0),
      child: Text(text,
          maxLines: maxLine,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: fontSize,color: textColor,fontWeight: fontWeight,)),
    );
  }
}
