import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  late String text;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  Color? color;
  MediumText({this.color,this.overflow,this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, fontWeight:fontWeight,overflow: overflow,color:color),
    );
  }
}
