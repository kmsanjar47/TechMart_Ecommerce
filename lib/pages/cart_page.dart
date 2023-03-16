import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/cart_item_box.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List? cartItems;

  double totalPriceCalculator(){
    double totalPrice = 0.0;
    if(cartItems!=null) {
      for(Map item in cartItems!){
          totalPrice += item["price"];

      }

    }
    return totalPrice;
  }
  fetchCartItems()async{
    dynamic ref = await FirestoreService().firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).get();
    ref.docs.forEach((element) {
      setState(() {
        cartItems = element.data()["cart"];
      });
    });
  }



  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    totalPriceCalculator();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(text: "Cart",),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
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
            BigText(
              text: "Total: ${totalPriceCalculator()}",
              fontWeight: FontWeight.bold,
            ),
            InkWell(
              onTap: () {

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
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.white,
                    ),
                    MediumText(
                      text: "Checkout",
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
      body: cartItems != null?ListView.builder(
        shrinkWrap: true,
           itemCount: cartItems?.length,
          itemBuilder: (BuildContext context, int index) {
            return CartItemBox(
              category: cartItems![index]["category"],
              title: cartItems![index]["title"],
              price: cartItems![index]["price"],
              imagePath: cartItems![index]["list_view_image_path"],
              dismissedFunction: (direction ) async{
                await FirestoreService().deleteCartItem(index, context);
              },
              index: index,
            );
          }):Container(),
    );
  }
}
