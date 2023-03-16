import 'package:e_commerce_app/pages/profile_edit_page.dart';
import 'package:e_commerce_app/widgets/user_profile_info_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controllers.dart';
import '../widgets/big_text.dart';
import '../widgets/title_text.dart';

class CheckOutPage extends StatefulWidget {
  final double totalPrice;

  const CheckOutPage(this.totalPrice, {Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  void initState() {
    super.initState();
    ProductController productController =
        Provider.of<ProductController>(context, listen: false);
    productController.fetchUserInfo(context);
    productController.fetchOrderItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (_, controller, ___) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(text: "User Credentials:"),
                    ElevatedButton(
                        onPressed: () async {
                          bool result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileEditPage(
                                  controller.userInfo["username"],
                                  controller.userInfo["name"],
                                  controller.userInfo["location"],
                                  controller.userInfo["country"]),
                            ),
                          );
                          if (result == true) {
                            setState(() {});
                          } else {}
                        },
                        child: const Text("Edit"))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                UserProfileInfoBox(
                    info: "Name: ${controller.userInfo["name"]}"),
                const SizedBox(
                  height: 8,
                ),
                UserProfileInfoBox(
                    info: "Location: ${controller.userInfo["location"]}"),
                const SizedBox(
                  height: 8,
                ),
                UserProfileInfoBox(
                    info: "Country: ${controller.userInfo["country"]}"),
                const SizedBox(
                  height: 15,
                ),
                TitleText(text: "Payment Options:"),
                Column(
                  children: [
                    RadioListTile(
                      title: Row(
                        children: [
                          controller.paymentGateway == "PayPal"
                              ? const Icon(
                                  Icons.paypal,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.paypal),
                          const SizedBox(
                            width: 3,
                          ),
                          BigText(text: "PayPal"),
                        ],
                      ),
                      value: "PayPal",
                      groupValue: controller.paymentGateway,
                      onChanged: (value) {
                        controller.paymentGateway = value.toString();
                        controller.notifyListeners();
                      },
                    ),
                    RadioListTile(
                      title: Row(
                        children: [
                          controller.paymentGateway == "Bank"
                              ? const Icon(
                                  Icons.payment,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.payment),
                          const SizedBox(
                            width: 3,
                          ),
                          BigText(text: "Bank"),
                        ],
                      ),
                      value: "Bank",
                      groupValue: controller.paymentGateway,
                      onChanged: (value) {
                        controller.paymentGateway = value.toString();
                        controller.notifyListeners();
                      },
                    ),
                    RadioListTile(
                      title: Row(
                        children: [
                          controller.paymentGateway == "Home Delivery"
                              ? const Icon(
                                  Icons.home,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.home),
                          const SizedBox(
                            width: 3,
                          ),
                          BigText(text: "Home Delivery"),
                        ],
                      ),
                      value: "Home Delivery",
                      groupValue: controller.paymentGateway,
                      onChanged: (value) {
                        controller.paymentGateway = value.toString();
                        controller.notifyListeners();
                      },
                    ),
                    controller.paymentTextGenerator(
                        context,
                        controller.paymentGateway,
                        widget.totalPrice.toString()),
                  ],
                )
              ],
            )),
      );
    });
  }
}
