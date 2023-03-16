import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product_model.dart';

class OrderModel {
  late Map _product;
  late String _deliveryDate;
  bool _isCompleted = false;
  String orderDate;


  OrderModel({required this.orderDate,required String deliveryDate, required Map product, required bool isCompleted}
      ){
    _deliveryDate = deliveryDate;
    _product = product;
    _isCompleted = isCompleted;
  }

  factory OrderModel.fromJson(DocumentSnapshot snapshot){
    return OrderModel(orderDate:snapshot.get("orderDate"),deliveryDate: snapshot.get("deliveryDate"),
    product: snapshot.get("product"),
    isCompleted: snapshot.get("isCompleted"));
  }
  Map<String,dynamic> toMap(){
    return {
      "product" : product,
      "orderDate" : orderDate,
      "deliveryDate": deliveryDate,
      "isCompleted" : isCompleted
    };
  }

  Map get product => _product;

  set product(Map value) {
    _product = value;
  }

  String get deliveryDate => _deliveryDate;

  set deliveryDate(String value) {
    _deliveryDate = value;
  }

  bool get isCompleted => _isCompleted;

  set isCompleted(bool value) {
    _isCompleted = value;
  }
}
