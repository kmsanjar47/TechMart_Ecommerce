import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final int totalOrders = 0;

  UserModel firestoreJsonParse(snapshot) {
    UserModel user = UserModel.fromJson(snapshot.data.docs[0]);
    print(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
          stream: FirestoreService()
              .firestore
              .collection("users")
              .where("id",
                  isEqualTo: "jltsO9iwqSVxSFLvNq8cBtOzwaL2")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.docs.length > 0){
                UserModel user = UserModel.fromJson(snapshot.data.docs[0]);
                print(snapshot.data.docs[0]);
                return Column(children: [
                  const CircleAvatar(),
                  Text("Username: ${firestoreJsonParse(snapshot).username}"),
                  Text("Name:${firestoreJsonParse(snapshot).name}"),
                  Text("Email:${firestoreJsonParse(snapshot).email}"),
                  Text("Location:${firestoreJsonParse(snapshot).location}"),
                  Text("Country:${firestoreJsonParse(snapshot).country}"),
                  Text("Account Created:${firestoreJsonParse(snapshot).dateCreated}"),
                  Text("Total Completed Orders: $totalOrders"),

                ],);
              }
            }
            else{
              return Container();
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
