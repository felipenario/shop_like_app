import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/utils/app_routes.dart';
import 'package:shop_like_app/views/smartphone_form_screen.dart';

class SmartphoneItem extends StatelessWidget {
  final Smartphone smartphone;
  final int index;
  final void Function(Smartphone, int) onEdit;
  final void Function(int) onDelete;

  SmartphoneItem({this.smartphone, this.index, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: FileImage(smartphone.image),
      ),
      title: Text(smartphone.model),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: AppRoutes.SMARTPHONE_FORM_SCREEN),
                    builder: (ctx) => SmartphoneFormScreen(smartphone: smartphone, onEdit: this.onEdit, index: this.index),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Smartphone'),
                    content: Text('Tem certeza?'),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Não'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Sim'),
                      )
                    ],
                  ),
                ).then((value) async {
                    this.onDelete(this.index);
                  }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
