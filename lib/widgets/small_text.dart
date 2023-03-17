import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final Color color;
  const SmallText({this.color = Colors.black,this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight:fontWeight, color: color),
    );
  }
}
