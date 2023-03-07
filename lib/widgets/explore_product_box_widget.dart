import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'medium_text.dart';

class ExploreProductBox extends StatelessWidget {
  const ExploreProductBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: 100,
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
          Image.asset("assets/product_images/keyboard.png"),
          //Column(product title,description)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MediumText(
                text: "Fantech G2324 MX Blue",
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              MediumText(text: "Mechanical Keyboard"),
              const SizedBox(
                height: 10,
              ),
              SmallText(text: "Regular Price: 2500TK"),
            ],
          ),
          //Price
        ],
      ),
    );
    ;
  }
}
