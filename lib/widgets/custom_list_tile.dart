import 'package:flutter/material.dart';

import 'big_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? borderRadius;
  final dynamic pageRoute;

  const CustomListTile({
    this.pageRoute,
    this.borderRadius,
    required this.title,
    required this.icon,

    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>pageRoute));
        },
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
