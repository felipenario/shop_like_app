import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_like_app/models/smartphone.dart';
import 'package:shop_like_app/utils/app_routes.dart';
import 'package:path/path.dart' as DartPath;

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
  final picker = ImagePicker();
  Smartphone _smartphone = Smartphone();
  bool _isEditing = false;

  _submitForm() {
    bool isValid = _form.currentState.validate();
    if (!isValid && _smartphone.imagePath == null) {
      _showImageErrorDialog();
      return;
    }
    _form.currentState.save();
    if(!_isEditing){
      _smartphone.id = Random().nextDouble().toString();
      widget.onSubmit(_smartphone);
    }else{
      widget.onEdit(_smartphone, widget.index);
    }
    Navigator.of(context).popUntil(ModalRoute.withName(AppRoutes.SMARTPHONE_SCREEN));
  }

  _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File tmpPickedFile = File(pickedFile.path);
    final Directory tmpDir = await getApplicationDocumentsDirectory();
    final String dirPath = tmpDir.path;
    final String fileName = DartPath.basename(pickedFile.path);
    final String fileExtension = DartPath.extension(pickedFile.path);
    tmpPickedFile = await tmpPickedFile.copy('$dirPath/$fileName$fileExtension');
    if(pickedFile != null){
      setState(() {
        _smartphone.imagePath = tmpPickedFile.path;
      });
      Navigator.pop(context);
    }
  }

  _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    File tmpPickedFile = File(pickedFile.path);
    final Directory tmpDir = await getApplicationDocumentsDirectory();
    final String dirPath = tmpDir.path;
    final String fileName = DartPath.basename(pickedFile.path);
    final String fileExtension = DartPath.extension(pickedFile.path);
    tmpPickedFile = await tmpPickedFile.copy('$dirPath/$fileName$fileExtension');
    if(pickedFile != null){
      setState(() {
        _smartphone.imagePath = tmpPickedFile.path;
      });
      Navigator.pop(context);
    }
  }

  _showModalBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.add_photo_alternate),
                title: Text("Selecionar foto da galeria"),
                onTap: () async {
                  await _getImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.add_a_photo),
                title: Text("Tirar foto com a camera"),
                onTap: () async {
                  await _getImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _showImageErrorDialog(){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro!"),
            content: Text("Adicione uma imagem ao anúncio!"),
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
  void initState() {
    if(widget.smartphone != null){
      _isEditing = true;
      _smartphone = widget.smartphone;
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
                        child: _smartphone.imagePath != null
                            ? InkWell(
                              borderRadius: BorderRadius.circular(25),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(
                                    File(_smartphone.imagePath),
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              onTap: (){
                                _showModalBottomSheet();
                              },
                            )
                            : IconButton(
                                icon: Icon(
                                  Icons.add_photo_alternate,
                                  size: 100,
                                ),
                                onPressed: (){
                                  _showModalBottomSheet();
                                },
                                color: Theme.of(context).accentColor,
                              ),
                      ),
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
