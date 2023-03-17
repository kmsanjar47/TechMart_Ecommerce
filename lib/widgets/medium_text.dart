import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final Color? color;
  const MediumText({this.color,this.overflow,this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, fontWeight:fontWeight,overflow: overflow,color:color),
    );
  }
}
