import 'package:flutter/material.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/utils/app_routes.dart';

class SmartphoneFormScreen extends StatefulWidget {
  final void Function(Smartphone) onSubmit;
  final void Function(Smartphone, int) onEdit;
  final int index;
  final Smartphone smartphone;

  SmartphoneFormScreen({this.onSubmit, this.smartphone, this.onEdit, this.index});

  @override
  _SmartphoneFormScreenState createState() => _SmartphoneFormScreenState();
}

class _SmartphoneFormScreenState extends State<SmartphoneFormScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _imageTextEditingController = TextEditingController();
  Smartphone _smartphone = Smartphone();
  bool _isEditing = false;

  _submitForm() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if(!_isEditing){
      widget.onSubmit(_smartphone);
    }else{
      widget.onEdit(_smartphone, widget.index);
    }
    Navigator.of(context).popUntil(ModalRoute.withName(AppRoutes.SMARTPHONE_SCREEN));
  }

  @override
  void initState() {
    if(widget.smartphone != null){
      _isEditing = true;
      _smartphone = widget.smartphone;
      _imageTextEditingController.text = _smartphone.imageUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!_isEditing ? "Adicionando Smartphone" : "Editando Smartphone"),
      ),
      body: ListView(
        children: [
          Form(
            key: _form,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor,
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: _smartphone.imageUrl != "" && _smartphone.imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  _smartphone.imageUrl,
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.image_not_supported,
                                size: 100,
                                color: Theme.of(context).accentColor,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _imageTextEditingController,
                      decoration: InputDecoration(
                        labelText: "URL",
                        prefixIcon: Icon(
                          Icons.image,
                            color: Theme.of(context).primaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _smartphone.imageUrl = _imageTextEditingController.text;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool objectValue = _smartphone.imageUrl == "" || _smartphone.imageUrl == null;
                        if (isEmpty || objectValue) {
                          return "Digite uma URL para a imagem do celular! \nOBS: Lembre-se de clicar no botão + para \nconfirmar a imagem a ser usada!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: !_isEditing ? null : _smartphone.model,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Modelo do Smartphone",
                      ),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe o modelo do smartphone!';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _smartphone.model = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: !_isEditing ? null : _smartphone.brand,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Marca do Smartphone",
                      ),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe a marca do smartphone!';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _smartphone.brand = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: !_isEditing ? null : _smartphone.price.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Preço do Smartphone",
                      ),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newValue = value.replaceAll(',', '.');
                        var newPrice = double.tryParse(newValue);
                        bool isInvalid = newPrice == null || newPrice <= 0;
                        if (isEmpty || isInvalid) {
                          return 'Informe um preço válido!';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _smartphone.price =
                              double.parse(value.replaceAll(',', '.'));
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                    child: RaisedButton(
                      elevation: 5,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(25),
                          ),
                      ),
                      onPressed: () => _submitForm(),
                      child: Text(!_isEditing ? "Adicionar Smartphone" : "Editar Smartphone", style: TextStyle(
                       color: Theme.of(context).accentColor,
                      ),
                      ),
                    ),
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
