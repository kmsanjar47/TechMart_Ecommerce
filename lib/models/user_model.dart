import 'package:e_commerce_app/models/product_model.dart';

class User {
  String? _name;
  String? _username;
  dynamic _id;
  String? _password;
  String? _email;
  String? _location;
  String? _country;
  List<Product>? _wishList;
  String? birthday;
  dynamic snapshot;
  List<Product>? _cart;
  List<Product>? _orders;


  User.name(
      this._name,
      this._username,
      this._id,
      this._password,
      this._email,
      this._location,
      this._country,
      this._wishList,
      this.birthday,
      this.snapshot,
      this._cart,
      this._orders,
      this._dateCreated);


  List<Product> get orders => _orders!;

  set orders(List<Product> value) {
    _orders = value;
  }
  List<Product> get cart => _cart!;

  set cart(List<Product> value) {
    _cart = value;
  }
  dynamic get id => _id!;

  set id(dynamic value) {
    _id = value;
  }
  String get name => _name!;


  set name(String value) {
    _name = value;
  }


  dynamic _dateCreated;

  String get username => _username!;

  set username(String value) {
    _username = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  String get email => _email!;

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
}
