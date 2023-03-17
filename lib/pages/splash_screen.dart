import 'package:e_commerce_app/controllers/product_controllers.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    ProductController productController =
        Provider.of<ProductController>(context, listen: false);
    productController.redirectToPage(context);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (_, controller, ___) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(
                text: "TechMart",
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset(
                  "assets/loader.json",

                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
