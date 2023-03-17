import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'medium_text.dart';

class CartItemBox extends StatelessWidget {
  final String category;
  final String title;
  final dynamic price;
  final int index;
  final String? imagePath;
  final void Function(DismissDirection)? dismissedFunction;

  const CartItemBox(
      {required this.dismissedFunction,
      required this.index,
      required this.category,
      this.imagePath,
      required this.title,
      required this.price,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: dismissedFunction,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("ALERT"),
                content: const Text("Are you sure want to delete?"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        return Navigator.of(context).pop(true);
                      },
                      child: const Text("Delete")),
                  ElevatedButton(
                      onPressed: () {
                        return Navigator.of(context).pop(false);
                      },
                      child: const Text("Cancel")),
                ],
              );
            });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
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
  }
}
