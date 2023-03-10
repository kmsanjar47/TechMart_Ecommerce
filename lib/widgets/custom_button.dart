import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Widget? centerItem;
  CustomButton({this.centerItem,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
            child: centerItem),
      ),
    );
  }
}
