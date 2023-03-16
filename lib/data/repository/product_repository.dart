import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository{
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  CollectionReference<Map<String, dynamic>> getProductRepoRef(){
    return firestore.collection("products");
  }
  Future<QuerySnapshot<Map<String, dynamic>>> fetchAllProductRepo()async {
    return await firestore.collection("products").get();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductSnapshotRepo(){
    return firestore.collection("products").snapshots();
  }
}