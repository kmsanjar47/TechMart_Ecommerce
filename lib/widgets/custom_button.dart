import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? centerItem;
  const CustomButton({this.centerItem,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-5.0, -5.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
          ],),
        child: Center(
            child: centerItem),
      ),
    );
  }
}
