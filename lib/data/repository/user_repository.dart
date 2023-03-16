import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_repository.dart';

class UserRepository{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> getUserRepoRef(){
    return firestore.collection("users");
  }

  Future<String?> fetchDocIdRepo()async{
    String? docId;
    CollectionReference userRef = UserRepository().getUserRepoRef();
    dynamic ref = await userRef
        .where("id",
        isEqualTo: AuthRepository().firebaseAuth.currentUser!.uid)
        .get();
    ref.docs.forEach((element) {
      docId = element.data()["docId"];
    });
    return docId;
  }
}