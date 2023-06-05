import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_commerce_app/Widgets/HomePage.dart';
import 'package:http/http.dart' as http;

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  AuthenticationState createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  final _formKey = GlobalKey<FormState>();
  final  _usernameController = TextEditingController();
  final  _passwordController = TextEditingController();

  Future<void> fetchData() async {
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/api/user/login'),
    body:{
      'username': _usernameController.text,
      'password': _passwordController.text
    },);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Traitez les données récupérées
    } else {
      // Gérez les erreurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGO",
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Username"),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        hintText: 'Username...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Password"),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        hintText: 'Password...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black26
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
