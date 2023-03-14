import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/pages/cart_page.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/medium_text.dart';
import 'package:e_commerce_app/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  dynamic productDoc;

  ProductPage(this.productDoc, {Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int pageViewIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,foregroundColor: Colors.black,),
      bottomNavigationBar: Container(
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
            InkWell(
              onTap: ()async{
                await FirestoreService().addToCart(widget.productDoc);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage(),),);
              },
              child: Container(
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
                  onPageChanged: (index){
                    setState(() {
                      pageViewIdx = index;
                      print(pageViewIdx);
                    });
                  },
                  itemCount: widget.productDoc["product_images_path"].length,
                    itemBuilder: (context,index){
                  return Image.asset(widget.productDoc["product_images_path"][index],fit: BoxFit.contain,);

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
                    SizedBox(height: 15,),
                    BigText(text: "Description:",color:Colors.black),
                    SizedBox(height: 15,),
                    MediumText(
                      text:
                     widget.productDoc["description"],
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
