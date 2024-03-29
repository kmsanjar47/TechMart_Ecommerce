import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'medium_text.dart';

class OrderItemBox extends StatelessWidget {
  final String category;
  final String title;
  final dynamic price;
  final String deliveryDate;
  final String orderPlaced;
  final bool isCompleted;
  const OrderItemBox({required this.orderPlaced,required this.isCompleted,required this.deliveryDate,required this.category,required this.title,required this.price,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height*0.3,
      decoration: BoxDecoration(
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
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //Product Image
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MediumText(
                text: title,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              MediumText(text: category),
              const SizedBox(
                height: 10,
              ),
              SmallText(text: "Regular Price: ${price}TK"),
            ],
          ),
          Column(children: [
            MediumText(text: "Delivery Date: ${deliveryDate.substring(0,10)}",fontWeight: FontWeight.bold,),
            SmallText(text: "Order PLaced On: $orderPlaced"),
            isCompleted? SmallText(text: "Completed", color: Colors.greenAccent,):
                SmallText(text: "Status: Delivering",color: Colors.blueAccent,)
            
          ],)
          //Price
        ],
      ),
    );
  }
}
