import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  late String text;
  FontWeight? fontWeight;
  Color color;
  SmallText({this.color = Colors.black,this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight:fontWeight, color: color),
    );
  }
}
