import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/views/smartphone_screen.dart';
import 'package:shop_like_app/widgets/app_drawer.dart';
import 'package:shop_like_app/widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Smartphone> _smartphones = [];

  void _addSmartphone(Smartphone smartphone) {
    setState(() {
      _smartphones.add(smartphone);
    });
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
                  builder: (ctx) => SmartphoneScreen(_addSmartphone),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _smartphones.length,
          itemBuilder: (context, index) {
            return ProductItem(_smartphones[index]);
          },
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
    );
  }
}
