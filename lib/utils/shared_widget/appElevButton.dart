import 'package:flutter/material.dart';

class AppElevButton extends StatelessWidget {

  final double? height;
  final double? width;
  final double? marginVer;
  final double? marginHor;
  final String text;
  final VoidCallback onPressed;

  const AppElevButton({
    super.key,
    this.height,
    this.width,
    this.marginVer,
    this.marginHor,
    required this.text,
    required this.onPressed

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVer??0,horizontal: marginHor??0),
      height: height,
        width: width,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(text)
        )
    );
  }
}
