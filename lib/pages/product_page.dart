import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/pages/cart_page.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/medium_text.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/product_controllers.dart';


class ProductPage extends StatefulWidget {
  dynamic productDoc;

  ProductPage(this.productDoc, {Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int pageViewIdx = 0;
  int newItemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          newItemCount != 0
              ? Container(
                  margin: const EdgeInsets.only(right: 15, top: 10),
                  child: InkWell(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Positioned(
                          left: 25,
                          bottom: 35,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              newItemCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            )),
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.cart,
                          size: 30,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        newItemCount == 0;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    child: const Icon(
                      CupertinoIcons.cart,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await ProductController()
                    .addWishlistItem(context, widget.productDoc);
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                    child: Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                await ProductController().addToCart(widget.productDoc, context);
                setState(() {
                  newItemCount += 1;
                });
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
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
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        pageViewIdx = index;
                      });
                    },
                    itemCount: widget.productDoc["product_images_path"].length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        widget.productDoc["product_images_path"][index],
                        fit: BoxFit.contain,
                      );
                    }),
              ),
              Center(
                child: DotsIndicator(
                  dotsCount: widget.productDoc["product_images_path"].length,
                  position: pageViewIdx.toDouble(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: widget.productDoc["title"],
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BigText(text: "Description:", color: Colors.black),
                    const SizedBox(
                      height: 15,
                    ),
                    MediumText(
                      text: widget.productDoc["description"],
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
