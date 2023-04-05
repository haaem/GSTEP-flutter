import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';

class TitleText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight weight;
  final overflow;
  final TextAlign textAlign;
  const TitleText({
    Key? key,
    this.size = 28,
    required this.text,
    this.color = primaryBlack,
    this.weight = FontWeight.bold,
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
        fontFamily: 'SFProBold',
        fontSize: size,
        fontWeight: weight,
        overflow: overflow,
      ),
    );
  }
}
