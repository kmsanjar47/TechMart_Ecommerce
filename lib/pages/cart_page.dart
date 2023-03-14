import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List cartItems = [];
  double totalPrice = 0.0;
  totalPriceCalculator(){
    for(List item in cartItems){
      for(Map items in item){
        totalPrice += items["price"].toDouble();
      }
      setState(() {
      });
    }
  }
  fetchCartItems()async{
    dynamic ref = await FirestoreService().firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).get();
    ref.docs.forEach((element) {
      setState(() {
        cartItems.add(element.data()["cart"]);
      });

    });
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
    totalPriceCalculator();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(text: "Cart",),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
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
              text: "Total: $totalPrice",
              fontWeight: FontWeight.bold,
            ),
            InkWell(
              onTap: () {
                totalPriceCalculator();
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
      body: ListView.builder(
          itemCount: cartItems[0].length,
          itemBuilder: (BuildContext context, int index) {
            return ExploreProductBox(
              category: cartItems[0][index]["category"],
              title: cartItems[0][index]["title"],
              price: cartItems[0][index]["price"],
              imagePath: cartItems[0][index]["list_view_image_path"],
            );
          }),
    );
  }
}
