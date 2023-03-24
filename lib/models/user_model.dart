import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? _name;
  late String _username;
  dynamic _id;
  late String _email;
  String? _location;
  String? _country;
  List? _wishList;
  List? _cart;
  List? _orders;
  String? docId;
  String type;

  UserModel({
    required this.type,
    this.docId,
    String? name,
    required String username,
    dynamic id,
    required String email,
    String? location,
    String? country,
    List? wishList,
    List? cart,
    List? orders,
    String? dateCreated}) {
    _name = name;
    _username = username;
    _id = id;
    _email = email;
    _location = location;
    _country = country;
    _wishList = wishList;
    _cart = cart;
    _orders = orders;
    _dateCreated = dateCreated;
  }

  List get orders => _orders ?? [];

  set orders(List value) {
    _orders = value;
  }

  List get cart => _cart ?? [];

  set cart(List value) {
    _cart = value;
  }

  dynamic get id => _id;

  set id(dynamic value) {
    _id = value;
  }

  String get name => _name ?? "Not Set";

  set name(String value) {
    _name = value;
  }

  dynamic _dateCreated;

  String get username => _username;

  set username(String value) {
    _username = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get location => _location ?? "Not Set";

  set location(String value) {
    _location = value;
  }

  String get country => _country ?? "Not Set";

  set country(String value) {
    _country = value;
  }

  List get wishList => _wishList ?? [];

  set wishList(List value) {
    _wishList = value;
  }

  dynamic get dateCreated => _dateCreated;

  set dateCreated(dynamic value) {
    _dateCreated = value;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "username": username,
      "id": id,
      "email": email,
      "location": location,
      "country": country,
      "wishList": wishList,
      "cart": cart,
      "orders": orders,
      "dateCreated": dateCreated,
      "docId":docId,
      "type":type
    };
  }
  factory UserModel.fromJson(DocumentSnapshot snapshot){
   return UserModel(
       name: snapshot.get("name"),
     username: snapshot.get("username"),
     id: snapshot.get("name"),
     email: snapshot.get("email"),
     location: snapshot.get("location"),
     country: snapshot.get("country"),
     wishList: snapshot.get("wishList"),
     cart: snapshot.get("cart"),
     orders: snapshot.get("orders"),
     dateCreated: snapshot.get("dateCreated"),
   docId:snapshot.id,
   type:snapshot.get("type"));
  }
}

