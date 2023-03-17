import 'package:e_commerce_app/controllers/product_controllers.dart';
import 'package:e_commerce_app/widgets/big_text.dart';
import 'package:e_commerce_app/widgets/order_item_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();
    ProductController productController = Provider.of<ProductController>(context,listen: false);
    productController.fetchAllOrderItems(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (_,controller,___) {
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
              itemCount: controller.oldOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderItemBox(
                    orderPlaced: controller.oldOrderList[index]["orderDate"],
                    isCompleted: controller.oldOrderList[index]["isCompleted"],
                    deliveryDate: controller.oldOrderList[index]["deliveryDate"],
                    category: controller.oldOrderList[index]["product"]["category"],
                    title: controller.oldOrderList[index]["product"]["title"],
                    price: controller.oldOrderList[index]["product"]["price"]);
              }),
        );
      }
    );
  }
}
