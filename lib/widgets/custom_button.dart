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
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
            child: centerItem),
      ),
    );
  }
}
