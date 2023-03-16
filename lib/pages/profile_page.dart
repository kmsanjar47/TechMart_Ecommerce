import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/pages/profile_edit_page.dart';
import 'package:e_commerce_app/widgets/cart_item_box.dart';
import 'package:e_commerce_app/widgets/explore_product_box_widget.dart';
import 'package:e_commerce_app/widgets/medium_text.dart';
import 'package:e_commerce_app/widgets/user_profile_info_box.dart';
import 'package:flutter/material.dart';

import '../widgets/big_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int totalOrders = 0;
  List productDoc = [];

  UserModel firestoreJsonParse(snapshot) {
    UserModel user = UserModel.fromJson(snapshot.data.docs[0]);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: StreamBuilder(
            stream: FirestoreService()
                .firestore
                .collection("users")
                .where("id",
                    isEqualTo: AuthService().firebaseAuth.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        CircleAvatar(
                          minRadius: 70,
                        ),
                        UserProfileInfoBox(
                            info:
                                "Username: ${firestoreJsonParse(snapshot).username}"),
                        UserProfileInfoBox(
                            info: "Name: ${firestoreJsonParse(snapshot).name}"),
                        UserProfileInfoBox(
                            info:
                                "Email: ${firestoreJsonParse(snapshot).email}"),
                        UserProfileInfoBox(
                            info:
                                "Location: ${firestoreJsonParse(snapshot).location}"),
                        UserProfileInfoBox(
                            info:
                                "Country: ${firestoreJsonParse(snapshot).country}"),
                        UserProfileInfoBox(
                            info:
                                "Account Created On: ${firestoreJsonParse(snapshot).dateCreated.toString().substring(0, 10)}"),
                        UserProfileInfoBox(
                            info: "Total Completed Orders: $totalOrders"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  AuthService().firebaseAuth.signOut();
                                },
                                child: const Text("Logout")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileEditPage(
                                          firestoreJsonParse(snapshot).username,
                                          firestoreJsonParse(snapshot).name,
                                          firestoreJsonParse(snapshot).location,
                                          firestoreJsonParse(snapshot).country),
                                    ),
                                  );
                                },
                                child: const Text("Edit")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  );
                }
              } else {
                return Container();
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
