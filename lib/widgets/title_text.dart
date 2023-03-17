import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color? color;
  const TitleText({this.color,this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 30, fontWeight:fontWeight,color: color),
    );
  }
}
