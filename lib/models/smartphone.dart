class Smartphone {
  String _model;
  String _brand;
  double _price;
  String _imageUrl;

  Smartphone();

  String get model {
    return _model;
  }

  set model(String newName) {
    _model = newName;
  }
  String get brand {
    return _brand;
  }

  set brand(String newBrand) {
    _brand = newBrand;
  }

  double get price {
    return _price;
  }

  set price(double newPrice) {
    _price = newPrice;
  }

  String get imageUrl {
    return _imageUrl;
  }

  set imageUrl(String newImageUrl) {
    _imageUrl = newImageUrl;
  }

}