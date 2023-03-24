import 'package:flutter/material.dart';

class NeuphormicButton extends StatelessWidget {
  final Function() onTap;
  final Color? color;
  final Color widgetColor;
  final Widget centerWidget;
  final double height;
  final double width;
  const NeuphormicButton({this.color,required this.width,required this.height,required this.onTap,required this.widgetColor,required this.centerWidget,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-5.0, -5.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: IconTheme(
          data: IconThemeData(
            size: 25.0,
            color: widgetColor,
          ),
          child: Center(child: centerWidget),
        ),
      ),
    );;
  }
}
