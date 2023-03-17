import 'dart:async';

import 'package:e_commerce_app/controllers/product_controllers.dart';
import 'package:e_commerce_app/pages/navigation_page.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderCompletedPage extends StatefulWidget {
  const OrderCompletedPage({Key? key}) : super(key: key);

  @override
  State<OrderCompletedPage> createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    ProductController productController = Provider.of<ProductController>(context,listen:false);
    productController.redirectToHomepage(context);
    productController.animationCtl = AnimationController(vsync: this);
  }
  @override
  void dispose() {
    ProductController productController = Provider.of<ProductController>(context,listen:false);
    productController.animationCtl.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (_,controller,___) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  "assets/103161-order-complete.json",
                  height: 250,
                  width: 250,
                  controller: controller.animationCtl,
                    onLoaded: (composition){
                    controller.animationCtl..duration = composition.duration..forward();

              }
                ),
              ),
              TitleText(text: "Order Placed")
            ],
          ),
        );
      }
    );
  }
}
