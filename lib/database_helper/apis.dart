import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Sign up

  Future<User?> signUpNewUser(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential);
    print(userCredential.user);
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

  void addNewUserData(String username, String email, String id) {
    CollectionReference users = firestore.collection("users");
    users.add(UserModel(
        username: username,
        email: email,
    id: id,
    )
        .toMap());
  }

  dynamic fetchAllUserDataSnapshot()async{
    return firestore.collection("users").where("id",isEqualTo: AuthService().firebaseAuth.currentUser!.uid).snapshots();
  }
}
