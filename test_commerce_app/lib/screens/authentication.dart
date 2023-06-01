import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super (key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Nature-Quotes.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100,),
              const Text("LOGO", style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
              const SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Username"),
                            const SizedBox(width: 10,),
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person, color: Colors.black),
                                hintText: 'username...',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 8.0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 50,),
                        Row(
                          children: [
                            const Text("Password"),
                            const SizedBox(width: 10,),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock, color: Colors.black),
                                hintText: 'password...',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 8.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}