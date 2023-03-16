import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/data/repository/user_repository.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:e_commerce_app/pages/order_completed_page.dart';
import 'package:e_commerce_app/pages/profile_edit_page.dart';
import 'package:e_commerce_app/widgets/user_profile_info_box.dart';
import 'package:flutter/material.dart';
import '../widgets/big_text.dart';
import '../widgets/title_text.dart';

class CheckOutPage extends StatefulWidget {
  final double totalPrice;

  const CheckOutPage(this.totalPrice, {Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List newOrderList = [];
  List orderItems = [];
  Map userInfo = {};
  String paymentGateway = "Home Delivery";

  fetchOrderItems() async {
    CollectionReference userRef = UserRepository().getUserRepoRef();
    dynamic ref = await userRef
        .where("id",
        isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
        .get();
    ref.docs.forEach((element) {
      setState(() {
        orderItems = element.data()["cart"];
      });
    });
  }

  Widget paymentTextGenerator(String paymentGateway) {
    if (paymentGateway == "PayPal") {
      return const Text(
        "PayPal Currently Not Available",
        style: TextStyle(color: Colors.red),
      );
    } else if (paymentGateway == "Bank") {
      return const Text(
        "Bank Payment Currently Not Available",
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Column(
        children: [
          const Divider(),
          Text("Total Price: ${widget.totalPrice}"),
          ElevatedButton(
            onPressed: () async {
              for (Map item in orderItems) {
                newOrderList.add(OrderModel(
                    orderDate: DateTime.now().toString().substring(0, 10),
                    deliveryDate: DateTime.now()
                        .add(const Duration(days: 15))
                        .toString(),
                    product: item,
                    isCompleted: false)
                    .toMap());

              }
              await FirestoreService().addOrders(newOrderList, context);
              await FirestoreService().clearCart(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderCompletedPage(),
                ),
              );
            },
            child: const Text("Proceed Order"),
          ),
        ],
      );
    }
  }

  fetchUserInfo(BuildContext context) async {
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
          isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        setState(() {
          userInfo = {
            "name": element.data()["name"],
            "username": element.data()["username"],
            "location": element.data()["location"],
            "country": element.data()["country"]
          };
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo(context);
    fetchOrderItems();
  }

  @override
  Widget build(BuildContext context) {
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
                  ElevatedButton(onPressed: () async {
                     bool result = await Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ProfileEditPage(
                                userInfo["username"], userInfo["name"],
                                userInfo["location"], userInfo["country"]),),);
                     if(result == true){
                       setState(() {

                       });
                     } else{}
                  }, child: const Text("Edit"))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              UserProfileInfoBox(info: "Name: ${userInfo["name"]}"),
              const SizedBox(
                height: 8,
              ),
              UserProfileInfoBox(info: "Location: ${userInfo["location"]}"),
              const SizedBox(
                height: 8,
              ),
              UserProfileInfoBox(info: "Country: ${userInfo["country"]}"),
              const SizedBox(
                height: 15,
              ),
              TitleText(text: "Payment Options:"),
              Column(
                children: [
                  RadioListTile(
                    title: Row(
                      children: [
                        paymentGateway == "PayPal"
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
                    groupValue: paymentGateway,
                    onChanged: (value) {
                      setState(() {
                        paymentGateway = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Row(
                      children: [
                        paymentGateway == "Bank"
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
                    groupValue: paymentGateway,
                    onChanged: (value) {
                      setState(() {
                        paymentGateway = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Row(
                      children: [
                        paymentGateway == "Home Delivery"
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
                    groupValue: paymentGateway,
                    onChanged: (value) {
                      setState(() {
                        paymentGateway = value.toString();
                      });
                    },
                  ),
                  paymentTextGenerator(paymentGateway),
                ],
              )
            ],
          )),
    );
  }
}
