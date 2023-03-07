import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  late String text;
  FontWeight? fontWeight;
  BigText({this.fontWeight,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontWeight:fontWeight),
    );
  }
}
