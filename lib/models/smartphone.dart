class Smartphone {
  String _name;
  double _price;

  Smartphone();

  String get name {
    return _name;
  }

  set name(String smartphoneName) {
    _name = smartphoneName;
  }

  double get price {
    return _price;
  }

  set price(double smartphonePrice) {
    _price = smartphonePrice;
  }

}