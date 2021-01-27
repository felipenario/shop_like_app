import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';

class SmartphoneFormScreen extends StatefulWidget {
  final void Function(Smartphone) onSubmit;

  SmartphoneFormScreen(this.onSubmit);

  @override
  _SmartphoneFormScreenState createState() => _SmartphoneFormScreenState();
}

class _SmartphoneFormScreenState extends State<SmartphoneFormScreen> {
  final _form = GlobalKey<FormState>();
  Smartphone _smartphone = Smartphone();

  _submitForm(){
    bool isValid = _form.currentState.validate();
    if(!isValid){
      return;
    }
    _form.currentState.save();
    widget.onSubmit(_smartphone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionando Smartphone"),
      ),
      body: ListView(
        children: [
          Form(
            key: _form,
              child: Container(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nome do Smartphone",
                      ),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe o nome do smartphone!';
                        }

                        return null;
                      },
                      onSaved: (value){
                        setState(() {
                          _smartphone.name = value;
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Preço do Smartphone",
                      ),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe o preço do smartphone!';
                        }

                        return null;
                      },
                      onSaved: (value){
                        setState(() {
                          _smartphone.price = double.parse(value);
                        });
                      },
                    ),
                    FlatButton(
                      onPressed: () => _submitForm(),
                      child: Text("Adicionar Smartphone"),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
