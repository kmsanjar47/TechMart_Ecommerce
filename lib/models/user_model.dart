import 'package:e_commerce_app/models/product_model.dart';

class User {
  String? _name;
  late String _username;
  dynamic _id;
  late String _password;
  late String _email;
  String? _location;
  String? _country;
  List<Product>? _wishList;
  String? birthday;
  dynamic snapshot;
  List<Product>? _cart;
  List<Product>? _orders;

  User(
      {String? name,
      required String username,
      dynamic id,
      required String password,
      required String email,
      String? location,
      String? country,
      List<Product>? wishList,
      this.birthday,
      this.snapshot,
      List<Product>? cart,
      List<Product>? orders}) {
    _name = name;
    _username = username;
    _id = id;
    _password = password;
    _email = email;
    _location = location;
    _country = country;
    _wishList = wishList;
    _cart = cart;
    _orders = orders;
    _dateCreated = dateCreated;
  }

  List<Product> get orders => _orders??[];

  set orders(List<Product> value) {
    _orders = value;
  }

  List<Product> get cart => _cart??[];

  set cart(List<Product> value) {
    _cart = value;
  }

  dynamic get id => _id;

  set id(dynamic value) {
    _id = value;
  }

  String get name => _name??"Not Set";

  set name(String value) {
    _name = value;
  }

  dynamic _dateCreated;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
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

  List<Product> get wishList => _wishList ?? [];

  set wishList(List<Product> value) {
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
      "password": password,
      "email": email,
      "location": location,
      "country": country,
      "wishList": wishList,
      "birthday": birthday,
      "snapshot": snapshot,
      "cart": cart,
      "orders": orders,
      "dateCreated": dateCreated
    };
  }
}

main() {
  List<User> userList = [
    User(
        username: "kmsanjar47",
        email: "kmsanjar47@gmail.com",
        password: "abcde",
    ),
    User(
      username: "kmsanjar007",
      email: "kmsanjar007@gmail.com",
      password: "abcde",
    ),
  ];
  for(User i in userList){
    print(i.toMap()["name"]);
  }
}
