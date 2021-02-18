import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_like_app/models/smartphone.dart';

class LocalStorageHive {
  Completer<Box> _instance = Completer<Box>();

  LocalStorageHive(){
    Hive.registerAdapter(SmartphoneAdapter());
    _init();
  }

  _init() async{
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox('db');
    _instance.complete(box);
  }

  Future saveSmartphoneList(List<Smartphone> smartphones) async{
    var box = await _instance.future;
    box.put('smartphoneList', smartphones);
  }
  
  Future<List<dynamic>> getSmartphoneList() async{
    var box = await _instance.future;

    return box.get('smartphoneList');
  }

}