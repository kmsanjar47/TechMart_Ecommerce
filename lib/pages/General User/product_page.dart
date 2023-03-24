import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/pages/General%20User/cart_page.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/medium_text.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controllers.dart';

class ProductPage extends StatelessWidget {
  final dynamic productDoc;

  const ProductPage(this.productDoc, {Key? key}) : super(key: key);

  // int pageViewIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (_, controller, __) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            controller.newItemCount != 0
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
                                controller.newItemCount.toString(),
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
                        controller.newItemCount == 0;
                        controller.notifyListeners();

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
            color: Colors.grey[200],
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
                  await controller.addWishlistItem(context, productDoc);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5.0, -5.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
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
                  await ProductController().addToCart(productDoc, context);
                  controller.newItemCount += 1;
                  controller.notifyListeners();
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5.0, -5.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        CupertinoIcons.cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 7,),
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
                        controller.pageViewIdx = index;
                        controller.notifyListeners();
                      },
                      itemCount: productDoc["product_images_path"].length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          productDoc["product_images_path"][index],
                          fit: BoxFit.contain,
                        );
                      }),
                ),
                Center(
                  child: DotsIndicator(
                    dotsCount: productDoc["product_images_path"].length,
                    position: controller.pageViewIdx.toDouble(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: productDoc["title"],
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
                        text: productDoc["description"],
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
    });
  }
}
