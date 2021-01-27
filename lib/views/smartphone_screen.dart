import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/utils/app_routes.dart';
import 'package:shop_like_app/views/smartphone_form_screen.dart';
import 'package:shop_like_app/widgets/smartphone_item.dart';

class SmartphoneScreen extends StatefulWidget {
  final void Function(Smartphone) onSubmit;
  final void Function(Smartphone, int) onEdit;
  final void Function(int) onDelete;
  final List<Smartphone> smartphones;

  SmartphoneScreen({this.onSubmit, this.onEdit, this.onDelete, this.smartphones});

  @override
  _SmartphoneScreenState createState() => _SmartphoneScreenState();
}

class _SmartphoneScreenState extends State<SmartphoneScreen> {

  void _onSubmit(Smartphone smartphone){
    widget.onSubmit(smartphone);
    setState(() {});
  }

  void _onDelete(int index){
    widget.onDelete(index);
    setState(() {});
  }

  void _onEdit(Smartphone smartphone, int index){
    widget.onEdit(smartphone, index);
    setState(() {});
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
                  settings: RouteSettings(name: AppRoutes.SMARTPHONE_FORM_SCREEN),
                  builder: (ctx) => SmartphoneFormScreen(onSubmit: _onSubmit),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: widget.smartphones.length,
          itemBuilder: (context, index) {
            return SmartphoneItem(smartphone: widget.smartphones[index], index: index, onEdit: _onEdit, onDelete: _onDelete);
          },
        )
      ),
    );
  }
}
