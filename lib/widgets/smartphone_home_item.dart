import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:url_launcher/url_launcher.dart';

class SmartphoneHomeItem extends StatelessWidget {
  final Smartphone _smartphone;

  SmartphoneHomeItem(this._smartphone);

  _showModalBottomSheet(BuildContext context, Smartphone smartphone){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Enviar por email"),
                onTap: () async {
                  _launchInEmail(smartphone, context);
                },
              ),
              ListTile(
                leading: Icon(Icons.sms),
                title: Text("Enviar por SMS"),
                onTap: () async {
                  _launchInSms(smartphone, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchInSms(Smartphone smartphone, BuildContext context) async {
    final Uri params = Uri(
      scheme: 'sms',
      path: '+553499999-8888',
      queryParameters: {
        'body': 'Smartphone: ${smartphone.brand} ${smartphone.model} Preço: ${smartphone.price}',
      },
    );
    final url = params.toString();
    if(await canLaunch(url)){
      await launch(url);
    }else{
      _showErrorDialog(context, "Erro ao enviar SMS");
    }
  }

  Future<void> _launchInEmail(Smartphone smartphone, BuildContext context) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'felipenario1@gmail.com',
      queryParameters: {
        'subject': 'Detalhes do Smartphone',
        'body': 'Smartphone: ${smartphone.brand} ${smartphone.model} Preço: ${smartphone.price}',
      },
    );
    final url = params.toString();
    if(await canLaunch(url)){
      await launch(url);
    }else{
      _showErrorDialog(context, "Erro ao enviar email");
    }
  }

  _showErrorDialog(BuildContext context, String msg){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Erro!"),
          content: Text(msg),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
          _showModalBottomSheet(context, _smartphone);
        },
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.file(
                    File(_smartphone.imagePath),
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      _smartphone.brand + " " + _smartphone.model,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.green),
                      SizedBox(width: 6),
                      Text('R\$${_smartphone.price}')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
