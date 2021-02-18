import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/repository/local_storage_hive.dart';
import 'package:shop_like_app/utils/app_routes.dart';
import 'package:shop_like_app/views/smartphone_screen.dart';
import 'package:shop_like_app/widgets/smartphone_home_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Smartphone> _smartphones = [];
  final LocalStorageHive localStorageHive = LocalStorageHive();

  void _addSmartphone(Smartphone smartphone) {
    setState(() {
      _smartphones.add(smartphone);
      localStorageHive.saveSmartphoneList(_smartphones);
    });
  }

  void _editSmartphone(Smartphone smartphone, int index){
    setState(() {
      _smartphones[index] = smartphone;
      localStorageHive.saveSmartphoneList(_smartphones);
    });
  }

  void _removeSmartphone(int index){
    setState(() {
      _smartphones.removeAt(index);
      localStorageHive.saveSmartphoneList(_smartphones);
    });
  }

  void _getLocalStorageSmartphoneList() async{
    var hiveList = await localStorageHive.getSmartphoneList();
    List<Smartphone> smartphoneList = hiveList.map((smartphone) => smartphone as Smartphone).toList();
    if(smartphoneList != null){
      _smartphones = smartphoneList;
    }
  }

  @override
  void initState() {
    _getLocalStorageSmartphoneList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: AppRoutes.SMARTPHONE_SCREEN),
                  builder: (ctx) => SmartphoneScreen(onSubmit: _addSmartphone, onEdit: _editSmartphone, onDelete: _removeSmartphone, smartphones: _smartphones),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _smartphones.length,
          itemBuilder: (context, index) {
            return SmartphoneHomeItem(_smartphones[index]);
          },
      ),
    );
  }
}
