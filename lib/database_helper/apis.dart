import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Sign up

  Future<User?> signUpNewUser(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  //Sign in

  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
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
      dateCreated: DateTime.now().toString()
    )
        .toMap());
    docId = ref.id;

    firestore.collection("users").doc(docId).update({"docId":docId});

  }
  addToCart(Map product)async {
    String docId = "";
    List oldCart = [];
    dynamic ref = await firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).get();
    ref.docs.forEach((element) {
      docId = element.data()["docId"];
      oldCart = element.data()["cart"];
    });
    oldCart.add(product);
    await firestore.collection("users").doc(docId).update({"cart":oldCart});
    print("added successfully");

  }
  // List<Map> fetchCartItems()async{
  //   List cartItems = [];
  //   dynamic ref = await firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).get();
  //   return ref.docs.forEach((element) {
  //     cartItems.add(element.data()["cart"]);
  //     return cartItems;
  //   });
  // }

  dynamic fetchAllUserDataSnapshot()async{
    return firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).snapshots();
  }
}
class ProductServices{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

 addAllProducts(){
   firestore.collection("products").add(
   ProductModel(
     distributor: "Fantech",
   title: "Fantech G2324 MX Blue",
   price: 2500,
   category: "Mechanical Keyboard",
   listViewImagePath: "assets/product_images/keyboard.png",
   productImagesPath: ["assets/product_images/keyboard.png"]).toMap(),
   );
 }


}
