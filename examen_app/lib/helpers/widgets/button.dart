import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.onPressed,
    this.buttonText = "",
    this.borderRadius = 25,
    this.fontSize = 25,
    this.margin = const EdgeInsets.all(0),
    this.padding,
    this.icon,
    required this.width,
    required this.height,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final String buttonText;
  final double fontSize;
  final EdgeInsets? padding;
  final Color buttonColor;
  final double borderRadius;
  final void Function()? onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      padding: const EdgeInsets.only(right: 0),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            padding: padding != null
                ? padding!
                : buttonText.length > 6
                    ? const EdgeInsets.fromLTRB(8, 8, 15, 8)
                    : const EdgeInsets.all(7),
            elevation: 5,
          ),
          child: Row(
            children: [
              Container(
                margin: buttonText.length > 6
                    ? const EdgeInsets.only(left: 15)
                    : null,
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              Expanded(child: Container()),
              icon != null ? icon! : Container(),
            ],
          )),
    );
  }
}
