import 'package:e_commerce_app/controllers/user_controllers.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/data/repository/user_repository.dart';
import 'package:e_commerce_app/pages/profile_edit_page.dart';
import 'package:e_commerce_app/widgets/user_profile_info_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (_, controller,___) {
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
                                    "Username: ${controller.firestoreJsonParse(snapshot).username}"),
                            UserProfileInfoBox(
                                info: "Name: ${controller.firestoreJsonParse(snapshot).name}"),
                            UserProfileInfoBox(
                                info:
                                    "Email: ${controller.firestoreJsonParse(snapshot).email}"),
                            UserProfileInfoBox(
                                info:
                                    "Location: ${controller.firestoreJsonParse(snapshot).location}"),
                            UserProfileInfoBox(
                                info:
                                    "Country: ${controller.firestoreJsonParse(snapshot).country}"),
                            UserProfileInfoBox(
                                info:
                                    "Account Created On: ${controller.firestoreJsonParse(snapshot).dateCreated.toString().substring(0, 10)}"),
                            UserProfileInfoBox(
                                info: "Total Completed Orders: ${controller.totalOrders}"),
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
                                              controller.firestoreJsonParse(snapshot).username,
                                              controller.firestoreJsonParse(snapshot).name,
                                              controller.firestoreJsonParse(snapshot).location,
                                              controller.firestoreJsonParse(snapshot).country),
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
    );
  }
}
