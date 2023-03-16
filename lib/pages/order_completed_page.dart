import 'dart:async';

import 'package:e_commerce_app/pages/navigation_page.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderCompletedPage extends StatefulWidget {
  const OrderCompletedPage({Key? key}) : super(key: key);

  @override
  State<OrderCompletedPage> createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> with TickerProviderStateMixin{
  late AnimationController animationCtl;
  
  redirectToHomepage(){
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationPage()), (route) => false);
    });
  }
  @override
  void initState() {
    super.initState();
    redirectToHomepage();
    animationCtl = AnimationController(vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    animationCtl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              "assets/103161-order-complete.json",
              height: 250,
              width: 250,
              controller: animationCtl,
                onLoaded: (composition){
                animationCtl..duration = composition.duration..forward();

          }
            ),
          ),
          TitleText(text: "Order Placed")
        ],
      ),
    );
  }
}
