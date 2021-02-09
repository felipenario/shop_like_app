import 'dart:io';

class Smartphone {
  String _model;
  String _brand;
  double _price;
  File _image;

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

  File get image {
    return _image;
  }

  set image(File newImage) {
    _image = newImage;
  }

}