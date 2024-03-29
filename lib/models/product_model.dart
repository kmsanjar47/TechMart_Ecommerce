import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String _title;
  late double _price;
  String? _description;
  String? _distributor;
  late String _category;
  double? _rating;
  List<String>? _productImagesPath;
  String? _listViewImagePath;
  String? dateAdded;
  String? distributorId;

  ProductModel({
    this.distributorId,
    this.dateAdded,
    required String title,
    required double price,
    String? description,
    String? distributor,
    required String category,
    double? rating,
    List<String>? productImagesPath,
    String? listViewImagePath}) {
    _title = title;
    _price = price;
    _description = description;
    _distributor = distributor;
    _category = category;
    _rating = rating;
    _productImagesPath = productImagesPath;
    _listViewImagePath = listViewImagePath;
  }


  String get listViewImagePath => _listViewImagePath!;

  set listViewImagePath(String value) {
    _listViewImagePath = value;
  }

  set title(String value) {
    _title = value;
  }

  String get title => _title;

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get description => _description ?? "No Description Given";

  set description(String value) {
    _description = value;
  }

  String get distributor => _distributor ?? "No Distributor Given";

  set distributor(String value) {
    _distributor = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  double get rating => _rating ?? 0.0;

  set rating(double value) {
    _rating = value;
  }

  List<String> get productImagesPath => _productImagesPath!;

  set productImagesPath(List<String> value) {
    _productImagesPath = value;
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "price": price,
      "description": description,
      "distributor": distributor,
      "category": category,
      "rating": rating,
      "product_images_path": productImagesPath,
      "list_view_image_path": listViewImagePath
    };
  }

  factory ProductModel.fromJson(DocumentSnapshot snapshot){
    return ProductModel(
        title: snapshot.get("title"),
        price: snapshot.get("price"),
        category: snapshot.get("category"),
    distributor: snapshot.get("distributor"),
    description: snapshot.get("description"),
    rating: snapshot.get("rating"),
    productImagesPath: snapshot.get("productImagesPath"),
    listViewImagePath: snapshot.get("listViewImagePath"),
    dateAdded: snapshot.get("dateAdded"),
    distributorId: snapshot.get("distributorId"));
  }
}