import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
class PublisherProfilePage extends StatelessWidget {
  const PublisherProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(onPressed: (){
          AuthRepository().firebaseAuth.signOut();
        }, child: const Text("LogOut")),
      ),
    );
  }
}
