import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/user_repository.dart';
import '../models/user_model.dart';

class UserController extends ChangeNotifier {
  //Profile Edit Page
  TextEditingController usernameTxtCtl = TextEditingController();

  TextEditingController locationTxtCtl = TextEditingController();

  TextEditingController countryTxtCtl = TextEditingController();

  TextEditingController nameTxtCtl = TextEditingController();

  //Auth New Registration
  addNewUserData(String username, String email, String id) async {
    String docId = "";
    CollectionReference userRef = UserRepository().getUserRepoRef();
    DocumentReference ref = await userRef.add(UserModel(
            username: username,
            email: email,
            id: id,
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
