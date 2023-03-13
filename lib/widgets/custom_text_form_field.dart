import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField(
      {this.obscureText = false,
      required this.validator,
      required this.hintText,
      required this.textEditingController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      margin: const EdgeInsets.all(2),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: textEditingController,
        autofocus: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45),
          fillColor: Colors.grey.shade300,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
