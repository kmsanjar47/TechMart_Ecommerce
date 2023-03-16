import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/product_repository.dart';
import '../data/repository/user_repository.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../pages/navigation_page.dart';
import '../pages/order_completed_page.dart';
import '../widgets/category_box_widget.dart';

class ProductController extends ChangeNotifier {
  //Orders Page

  List oldOrderList = [];

  fetchAllOrderItems(BuildContext context) async {
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        oldOrderList = element.data()["orders"];
        notifyListeners();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //Order Completed Page

  late AnimationController animationCtl;

  redirectToHomepage(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPage()),
          (route) => false);
    });
  }

  //Dashboard Page

  List<CategoryBox> categoryBoxList = const [
    CategoryBox(
        categoryName: "Keyboard",
        imagePath: "assets/category_icons/controller.png"),
    CategoryBox(
        categoryName: "Mouse", imagePath: "assets/category_icons/mouse.png"),
    CategoryBox(
        categoryName: "Ram", imagePath: "assets/category_icons/ram-memory.png"),
    CategoryBox(
        categoryName: "HDD", imagePath: "assets/category_icons/hdd.png"),
    CategoryBox(
        categoryName: "GPU", imagePath: "assets/category_icons/gpu.png"),
    CategoryBox(
        categoryName: "CPU", imagePath: "assets/category_icons/cpu.png"),
    CategoryBox(
        categoryName: "Laptop", imagePath: "assets/category_icons/laptop.png"),
    CategoryBox(
        categoryName: "PC", imagePath: "assets/category_icons/computer.png"),
    CategoryBox(
        categoryName: "Projector",
        imagePath: "assets/category_icons/projector.png"),
    CategoryBox(
        categoryName: "Headphones",
        imagePath: "assets/category_icons/headphones.png"),
  ];
  List productDoc = [];

  fetchProducts() async {
    var result = await ProductRepository().fetchAllProductRepo();
    result.docs.forEach((element) {
      productDoc.add(element.data());
      notifyListeners();
    });
  }

//Checkout Page

  List newOrderList = [];
  List orderItems = [];
  Map userInfo = {};
  String paymentGateway = "Home Delivery";

  fetchOrderItems() async {
    CollectionReference userRef = UserRepository().getUserRepoRef();
    dynamic ref = await userRef
        .where("id", isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
        .get();
    ref.docs.forEach((element) {
      orderItems = element.data()["cart"];
      notifyListeners();
    });
  }

  Widget paymentTextGenerator(
      BuildContext context, String paymentGateway, String totalPrice) {
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
          Text("Total Price: ${totalPrice}"),
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
              await ProductController().addOrders(newOrderList, context);
              await ProductController().clearCart(context);
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
        userInfo = {
          "name": element.data()["name"],
          "username": element.data()["username"],
          "location": element.data()["location"],
          "country": element.data()["country"]
        };
        notifyListeners();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //Cart Page
  List cartItems = [];

  double totalPriceCalculator() {
    double totalPrice = 0.0;

    for (Map item in cartItems) {
      totalPrice += item["price"];
    }
    return totalPrice;
  }

  fetchCartItems() async {
    CollectionReference userRef = UserRepository().getUserRepoRef();
    dynamic ref = await userRef
        .where("id", isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
        .get();
    ref.docs.forEach((element) {
      cartItems = element.data()["cart"];
      notifyListeners();
    });
  }

  //Cart

  addToCart(Map product, BuildContext context) async {
    String docId = "";
    List oldCart = [];
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldCart = element.data()["cart"];
      });
      oldCart.add(product);
      await userRef.doc(docId).update({"cart": oldCart});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product Added Successfully"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  deleteCartItem(int index, BuildContext context) async {
    String docId = "";
    List oldCart = [];
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldCart = element.data()["cart"];
      });
      oldCart.removeAt(index);
      await userRef.doc(docId).update({"cart": oldCart});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  clearCart(BuildContext context) async {
    String docId = "";
    List newCart = [];
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
      });
      await userRef.doc(docId).update({"cart": newCart});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //Wishlist

  addWishlistItem(BuildContext context, Map product) async {
    String docId = "";
    List oldWishlist = [];
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldWishlist = element.data()["wishList"];
      });
      oldWishlist.add(product);
      await userRef.doc(docId).update({"wishList": oldWishlist});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added to Wishlist"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  removeWishlistItem(BuildContext context, int index) async {
    String docId = "";
    List oldWishlist = [];
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldWishlist = element.data()["wishList"];
      });
      oldWishlist.removeAt(index);
      await userRef.doc(docId).update({"wishList": oldWishlist});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //Orders

  addOrders(List product, BuildContext context) async {
    String docId = "";
    List oldOrderList = [];
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldOrderList = element.data()["orders"];
      });
      for (var element in product) {
        oldOrderList.add(element);
      }
      print(oldOrderList);
      await userRef.doc(docId).update({"orders": oldOrderList});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  addAllProducts() {
    ProductRepository().getProductRepoRef().add(
          ProductModel(
                  distributor: "Fantech",
                  title: "Fantech G2324 MX Blue",
                  price: 2500,
                  category: "Mechanical Keyboard",
                  listViewImagePath: "assets/product_images/keyboard.png",
                  productImagesPath: ["assets/product_images/keyboard.png"])
              .toMap(),
        );
  }
}
