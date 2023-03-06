class Product{
  String? _name;
  String? _price;
  String? _description;
  String? _distributor;
  String? _category;
  double? _rating;
  List<String>? _productImagesPath;

  set name(String value) {
    _name = value;
  }

  String get name => _name!;

  String get price => _price!;

  set price(String value) {
    _price = value;
  }

  String get description => _description!;

  set description(String value) {
    _description = value;
  }

  String get distributor => _distributor!;

  set distributor(String value) {
    _distributor = value;
  }

  String get category => _category!;

  set category(String value) {
    _category = value;
  }

  double get rating => _rating!;

  set rating(double value) {
    _rating = value;
  }

  List<String> get productImagesPath => _productImagesPath!;

  set productImagesPath(List<String> value) {
    _productImagesPath = value;
  }
}