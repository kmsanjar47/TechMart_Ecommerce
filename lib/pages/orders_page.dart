import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/order_item_box.dart';
import 'package:flutter/material.dart';

import '../data/repository/user_repository.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List oldOrderList = [];

  fetchOrderItems(BuildContext context) async {
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
          isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        setState(() {
          oldOrderList = element.data()["orders"];
        });
      });
      print(oldOrderList.length);
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
    fetchOrderItems(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: BigText(
          text: "Place Order",
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
          itemCount: oldOrderList.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderItemBox(
                orderPlaced: oldOrderList[index]["orderDate"],
                isCompleted: oldOrderList[index]["isCompleted"],
                deliveryDate: oldOrderList[index]["deliveryDate"],
                category: oldOrderList[index]["product"]["category"],
                title: oldOrderList[index]["product"]["title"],
                price: oldOrderList[index]["product"]["price"]);
          }),
    );
  }
}
