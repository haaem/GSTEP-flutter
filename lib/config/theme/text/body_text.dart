import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';

class BodyText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight weight;
  final overflow;
  final TextAlign textAlign;
  const BodyText({
    Key? key,
    this.size = 16,
    required this.text,
    this.color = primaryNavy,
    this.weight = FontWeight.normal,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.start
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontFamily: 'SFProRegular',
        fontSize: size,
        fontWeight: weight,
        overflow: overflow,
      ),
    );
  }
}
