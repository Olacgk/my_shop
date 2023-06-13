import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _serialNumberController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _marqueController = TextEditingController();
  TextEditingController _etatController = TextEditingController();


  @override
  void dispose() {
    _serialNumberController.dispose();
    _detailController.dispose();
    _priceController.dispose();
    _marqueController.dispose();
    _typeController.dispose();
    _etatController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/produit/new-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String> {
          'numSerie': _serialNumberController.text,
          'marque': _marqueController.text,
          'type': _typeController.text,
          'detail': _detailController.text,
          'price': _priceController.text,
          'etat': _etatController.text
        },)
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Succès'),
              content: Text('La requête a été effectuée avec succès.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur'),
              content: Text('La requête a échoué. Veuillez réessayer plus tard.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _serialNumberController,
                decoration: InputDecoration(labelText: 'Numéro de série'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de série';
                  }
                  return null;
                },
              ),
              const Spacer(),
              TextFormField(
                controller: _detailController,
                decoration: InputDecoration(labelText: 'Détail'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _typeController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un type';
                  }
                  return null;
                },
              ),
              const Spacer(),
              TextFormField(
                controller: _marqueController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Marque'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une marque';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _etatController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Etat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un état';
                  }
                  return null;
                },
              ),
              const Spacer(),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Prix'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: (){
                  _submitForm();
                  _formKey.currentState?.reset();
                },
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void showAddProductDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ajouter un produit'),
        content: AddProductPage(),
      );
    },
  );
}
