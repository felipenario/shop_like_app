import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/views/smartphone_form_screen.dart';

class SmartphoneScreen extends StatelessWidget {
  final void Function(Smartphone) onSubmit;

  SmartphoneScreen(this.onSubmit);

  void _addSmartphone(Smartphone smartphone){
    this.onSubmit(smartphone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => SmartphoneFormScreen(_addSmartphone),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {},
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [],
          )
        ),
      ),
    );
  }
}
