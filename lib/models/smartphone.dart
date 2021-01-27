class Smartphone {
  String _name;
  String _brand;
  double _price;
  String _imageUrl;

  Smartphone();

  String get name {
    return _name;
  }

  set name(String newName) {
    _name = newName;
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