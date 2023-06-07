import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _serialNumberController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  // List<String> _types = [];
  // List<String> _brands = [];
  String _selectedType = '';
  String _selectedBrand = '';

  Future<List<String>> _fetchTypes() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/type/types'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to fetch types');
    }
  }

  Future<List<String>> _fetchBrands() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/marque/marques'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to fetch brands');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTypes().then((types) {
      setState(() {
        _types = types;
      });
    });
    _fetchBrands().then((brands) {
      setState(() {
        _brands = brands;
      });
    });
  }

  @override
  void dispose() {
    _serialNumberController.dispose();
    _detailController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Envoyer les données au serveur
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/produit/new-product'),
        body: {
          'serialNumber': _serialNumberController.text,
          'brand': _selectedBrand,
          'type': _selectedType,
          'detail': _detailController.text,
          'price': _priceController.text,
        },
      );
      if (response.statusCode == 200) {
        // Traitement de la réponse réussie
        // par exemple, afficher un message de succès ou rediriger vers une autre page
      } else {
        // Traitement de la réponse d'échec
        // par exemple, afficher un message d'erreur
      }
    }
  }

  List<String> _brands = ['Marque 1', 'Marque 2', 'Marque 3'];
  List<String> _types = ['Type 1', 'Type 2', 'Type 3'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
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
                  const SizedBox(width: 16.0),
                  TextFormField(
                    controller: _detailController,
                    decoration: InputDecoration(labelText: 'Détail'),
                  ),

                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedBrand,
                    items: _brands.map((brand) {
                      return DropdownMenuItem<String>(
                        value: brand,
                        child: Text(brand),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBrand = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Marque'),
                  ),
                  SizedBox(width: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    items: _types.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Type'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
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
                onPressed: _submitForm,
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
