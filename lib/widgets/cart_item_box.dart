import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'medium_text.dart';

class CartItemBox extends StatelessWidget {
  late String category;
  late String title;
  late dynamic price;
  late int index;
  String? imagePath;
  void Function(DismissDirection)? dismissedFunction;


  CartItemBox(
      { required this.dismissedFunction, required this.index, required this.category, this.imagePath, required this.title, required this.price, Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(8),),
        ),
        child: Center(child: Icon(Icons.delete,color: Colors.white,),),
      ),
      onDismissed: dismissedFunction,
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("ALERT"),
            content: Text("Are you sure want to delete?"),
            actions: [
              ElevatedButton(onPressed: () {
                return Navigator.of(context).pop(true);
              }, child: Text("Delete")),
              ElevatedButton(onPressed: () {
                return Navigator.of(context).pop(false);
              }, child: Text("Cancel")),
            ],
          );
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 14,
              offset: const Offset(4, 4),
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 14,
              offset: Offset(-4, -4),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Product Image
            Image.asset(imagePath ?? "assets/category_icons/controller.png"),
            //Column(product title,description)
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
            //Price
          ],
        ),
      ),
    );
    ;
  }
}
