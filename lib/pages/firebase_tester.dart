import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/pages/pages.dart';
import 'package:flutter/material.dart';

class FirebaseTester extends StatefulWidget {
  const FirebaseTester({Key? key}) : super(key: key);

  @override
  State<FirebaseTester> createState() => _FirebaseTesterState();
}

class _FirebaseTesterState extends State<FirebaseTester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${AuthService().firebaseAuth.currentUser!.uid}"),
            ElevatedButton(
              onPressed: () {
                AuthService().firebaseAuth.signOut();
              },
              child: Text("Sign Out"),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                // FirestoreService().fetchAllUserData();
            }, child: Text("Profile Page"),),
          ],
        ),
      ),
    );
  }
}
