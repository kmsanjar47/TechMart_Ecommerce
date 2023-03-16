import 'package:flutter/material.dart';

import 'big_text.dart';

class UserProfileInfoBox extends StatelessWidget {
  late String info;
  UserProfileInfoBox({required this.info,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 5,left: 5),

      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(width: 3,color: Colors.white),
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Center(
        child: BigText(text:
        info),
      ),
    );
  }
}
