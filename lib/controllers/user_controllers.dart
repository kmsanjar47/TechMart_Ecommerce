import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/user_repository.dart';
import '../models/user_model.dart';

class UserController extends ChangeNotifier {
  //Profile Page

  final int totalOrders = 0;
  List productDoc = [];

  UserModel firestoreJsonParse(snapshot) {
    UserModel user = UserModel.fromJson(snapshot.data.docs[0]);
    return user;
  }

  //Sign in / Sign up Page / Publisher Sign up
  TextEditingController userNameTxtCtl = TextEditingController();
  TextEditingController publisherNameTxtCtl = TextEditingController();
  TextEditingController emailTxtCtl = TextEditingController();
  TextEditingController passwordTxtCtl = TextEditingController();

  String userType = "";

  getUserType(BuildContext context) async {
    userType = "";

    try {
      QuerySnapshot<Map<String, dynamic>> docRef = await UserRepository()
          .getUserRepoRef()
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      docRef.docs.forEach((element) {
        userType = element.data()["type"];
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

  //Profile Edit Page
  TextEditingController usernameTxtCtl = TextEditingController();

  TextEditingController locationTxtCtl = TextEditingController();

  TextEditingController countryTxtCtl = TextEditingController();

  TextEditingController nameTxtCtl = TextEditingController();

  //Auth New Registration
  addNewUserData(String username, String email, String id, String type) async {
    String docId = "";
    CollectionReference userRef = UserRepository().getUserRepoRef();
    DocumentReference ref = await userRef.add(UserModel(
            username: username,
            email: email,
            id: id,
            type: type,
            dateCreated: DateTime.now().toString())
        .toMap());
    docId = ref.id;

    userRef.doc(docId).update({"docId": docId});
  }

  //Profile info

  updateUserProfileInfo(BuildContext context,
      {required String name,
      required String username,
      required String location,
      required String country}) async {
    String docId = "";
    try {
      CollectionReference userRef = UserRepository().getUserRepoRef();
      dynamic ref = await userRef
          .where("id",
              isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
          .get();
      ref.docs.forEach((element) {
        docId = element.data()["docId"];
      });

      await userRef.doc(docId).update({
        "username": username,
        "name": name,
        "location": location,
        "country": country
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Updated Successfully"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<Map> fetchUserInfo(BuildContext context) async {
    Map userInfo = {};
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
}
