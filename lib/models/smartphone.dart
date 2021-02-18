import 'dart:io';

import 'package:hive/hive.dart';

part 'smartphone.g.dart';


@HiveType(typeId: 1)
class Smartphone extends HiveObject {
  @HiveField(0)
  String _id;
  @HiveField(1)
  String _model;
  @HiveField(2)
  String _brand;
  @HiveField(3)
  double _price;
  @HiveField(4)
  String _imagePath;

  Smartphone();

  String get id {
    return _id;
  }

  set id(String newId){
    _id = newId;
  }

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

  String get imagePath {
    return _imagePath;
  }

  set imagePath(String newImage) {
    _imagePath = newImage;
  }

}