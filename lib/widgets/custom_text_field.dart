import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController? textEditingController;
  const CustomTextField({this.obscureText = false,required this.textEditingController,required this.hintText,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: TextField(
        obscureText: obscureText,
        controller: textEditingController,
        autofocus: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: Colors.grey.shade300,
          filled: true,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 2),
            borderRadius: BorderRadius.all(Radius.circular(5),),
          ),
        ),
      ),
    );
  }
}
