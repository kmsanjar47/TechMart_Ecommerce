import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/data/repository/user_repository.dart';
import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/pages/profile_edit_page.dart';
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
            stream: UserRepository()
                .firestore
                .collection("users")
                .where("id",
                    isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const CircleAvatar(
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
                                  AuthRepository().firebaseAuth.signOut();
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
                        const SizedBox(
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
