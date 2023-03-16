import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Sign up

  Future<User?> signUpNewUser(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  //Sign in

  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addNewUserData(String username, String email, String id) async {
    String docId = "";
    CollectionReference users = firestore.collection("users");
    DocumentReference ref = await users.add(UserModel(
            username: username,
            email: email,
            id: id,
            dateCreated: DateTime.now().toString())
        .toMap());
    docId = ref.id;

    firestore.collection("users").doc(docId).update({"docId": docId});
  }

  //Cart
  addToCart(Map product, BuildContext context) async {
    String docId = "";
    List oldCart = [];
    try {
      dynamic ref = await firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldCart = element.data()["cart"];
      });
      oldCart.add(product);
      await firestore.collection("users").doc(docId).update({"cart": oldCart});
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
      dynamic ref = await firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldCart = element.data()["cart"];
      });
      oldCart.removeAt(index);
      await firestore.collection("users").doc(docId).update({"cart": oldCart});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  // List<Map> fetchCartItems()async{
  //   List cartItems = [];
  //   dynamic ref = await firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).get();
  //   return ref.docs.forEach((element) {
  //     cartItems.add(element.data()["cart"]);
  //     return cartItems;
  //   });
  // }

  //wishlist
  addWishlistItem(BuildContext context, Map product) async {
    String docId = "";
    List oldWishlist = [];
    try {
      dynamic ref = await firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldWishlist = element.data()["wishList"];
      });
      oldWishlist.add(product);
      await firestore
          .collection("users")
          .doc(docId)
          .update({"wishList": oldWishlist});
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
      dynamic ref = await firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
        oldWishlist = element.data()["wishList"];
      });
      oldWishlist.removeAt(index);
      await firestore
          .collection("users")
          .doc(docId)
          .update({"wishList": oldWishlist});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //Profile info
  updateUserProfileInfo(BuildContext context,
      {required String name,
      required String username,
      required String location,
      required String country}) async {
    String docId = "";
    try {
      dynamic ref = await firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
      });

      await firestore.collection("users").doc(docId).update({
        "username": username,
        "name": name,
        "location": location,
        "country": country
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Updated Successfully"),
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
  Future<Map> fetchUserInfo(BuildContext context)async{
    Map userInfo = {};
    try {
      dynamic ref = await firestore
          .collection("users")
          .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        userInfo = {"name":element.data()["name"],
        "username":element.data()["username"],
        "location":element.data()["location"],
        "country":element.data()["country"]};
      });



    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    return userInfo;
  }

  dynamic fetchAllUserDataSnapshot() async {
    return firestore
        .collection("users")
        .where("id", isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
        .snapshots();
  }
}

class ProductServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addAllProducts() {
    firestore.collection("products").add(
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
