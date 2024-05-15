import 'package:flutter/widgets.dart';

class BoldText extends StatelessWidget {
  final String data;
  final double fontSize;
  final TextAlign textAlign;

  const BoldText(String s, {
    super.key,
    required this.data,
    this.fontSize = 16,
    this.textAlign = TextAlign.left, required TextStyle style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
      textAlign: textAlign,
    );
  }
}