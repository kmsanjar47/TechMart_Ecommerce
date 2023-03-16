import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/order_item_box.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List oldOrderList = [];

  fetchOrderItems(BuildContext context) async {
    try {
      dynamic ref = await FirestoreService()
          .firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        setState(() {
          oldOrderList = element.data()["orders"];
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

  updateOrderStatus() async {
    late String docId;
    bool orderListStatus;
    List oldOrderList;
    try {
      dynamic ref = await FirestoreService()
          .firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldOrderList = element.data()["orders"];
        // oldOrderList["isCompleted"] = true;
      });
      // await FirestoreService().firestore.collection("users").doc(docId).update(data)

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
