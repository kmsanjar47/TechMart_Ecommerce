import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color? color;
  const BigText({this.color,this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight:fontWeight,color: color),
    );
  }
}
