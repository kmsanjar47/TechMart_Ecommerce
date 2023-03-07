class Product{
  String? _title;
  String? _price;
  String? _description;
  String? _distributor;

  Product.name(
      this._title,
      this._price,
      this._description,
      this._distributor,
      this._category,
      this._rating,
      this._productImagesPath,
      this._listViewImagePath);

  String? _category;
  double? _rating;
  List<String>? _productImagesPath;
  String? _listViewImagePath;

  String get listViewImagePath => _listViewImagePath!;

  set listViewImagePath(String value) {
    _listViewImagePath = value;
  }

  set title(String value) {
    _title = value;
  }

  String get title => _title!;

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