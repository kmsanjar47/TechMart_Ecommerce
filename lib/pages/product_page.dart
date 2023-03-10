import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/medium_text.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,foregroundColor: Colors.black,),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                  child: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              )),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                  ),
                  MediumText(
                    text: "ADD TO CART",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ],
              )),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/product_images/keyboard.png"),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [TitleText(text: "Logitech g5234 MX Blue")],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: "Fantech G2435 MX BLUE",
                        color: Colors.white,
                      ),
                      SizedBox(height: 15,),
                      BigText(text: "Description:",color:Colors.white),
                      SizedBox(height: 15,),
                      MediumText(
                        text:
                            "HJKAHSDJKASHDJKHAJKSHDKJ sdkjahskdjhask asjdhaskjhdajksh asjkdhasjkdhasd",
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
