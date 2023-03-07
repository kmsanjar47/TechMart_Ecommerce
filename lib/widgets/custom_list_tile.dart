import 'package:flutter/material.dart';

import 'big_text.dart';

class CustomListTile extends StatelessWidget {
  late String title;
  late IconData icon;
  double? borderRadius;

  CustomListTile({
    this.borderRadius,
    required this.title,
    required this.icon,

    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(

      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius??5), //<-- SEE HERE
        ),
        tileColor: Colors.black,
        textColor: Colors.white,
        iconColor: Colors.white,
        title: BigText(
          text: title,
        ),
        leading: Icon(icon),
      ),
    );
  }
}
