import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: BigText(text: "Place Order",color: Colors.black,),),

    );
  }
}
