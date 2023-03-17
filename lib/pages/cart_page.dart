import 'package:e_commerce_app/pages/checkout_page.dart';
import 'package:e_commerce_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controllers.dart';
import '../widgets/cart_item_box.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ProductController productController = Provider.of<ProductController>(context,listen: false);
    productController.fetchCartItems();

    return Consumer<ProductController>(
      builder: (_,controller,___) {
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
                  text: "Total: ${controller.totalPriceCalculator()}",
                  fontWeight: FontWeight.bold,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage(controller.totalPriceCalculator())),);

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
            shrinkWrap: true,
               itemCount: controller.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItemBox(
                  category: controller.cartItems[index]["category"],
                  title: controller.cartItems[index]["title"],
                  price: controller.cartItems[index]["price"],
                  imagePath: controller.cartItems[index]["list_view_image_path"],
                  dismissedFunction: (direction ) async{
                    await controller.deleteCartItem(index, context);
                  },
                  index: index,
                );
              })
        );
      }
    );
  }
}
