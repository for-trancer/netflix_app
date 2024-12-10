import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final double iconSize;
  final double textSize;
  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    this.iconSize = 30,
    this.textSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
