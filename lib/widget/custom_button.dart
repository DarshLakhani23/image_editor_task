import 'package:flutter/material.dart';
import 'package:image_editor/utils/size_utils.dart';
import 'package:image_editor/widget/app_text.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Color buttonColor;
  final Color? textColor;
  final String text;
  final double? fontSize;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.buttonColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
    this.fontWeight,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? SizeUtils.horizontalBlockSize * 10,
        width: width ?? SizeUtils.horizontalBlockSize * 20,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 1.5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
          child: Align(
            alignment: Alignment.center,
            child: AppText(
              text: text,
              color: textColor,
              fontWeight: fontWeight ?? FontWeight.bold,
              fontSize: fontSize ?? SizeUtils.fSize_14(),
            ),
          ),
        ),
      ),
    );
  }
}
