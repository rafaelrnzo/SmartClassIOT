// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smartclass/global/constant.dart';
import 'package:flutter_smartclass/mainNavigation.dart';
import 'package:flutter_smartclass/model/api_response.dart';
import 'package:flutter_smartclass/model/user.dart';
import 'package:flutter_smartclass/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              Container(
                height: height * 0.35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 125, 251, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          const SizedBox(
                            height: 17,
                          ),
                          const Icon(
                            Icons.charging_station_outlined,
                            size: 40,
                            color: Color.fromARGB(255, 18, 50, 97),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(0.0, -90.0, 0.0),
                    padding: const EdgeInsets.all(15.0),
                    height: 450,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                              top: 30,
                              bottom: 10,
                            ),
                            child: const Text(
                              'S P K L U',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            'Sign in your account.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 25,
                                    right: 30,
                                    left: 30,
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      labelText: "Email",
                                      hintText: "Masukkan email",
                                      prefixIcon: const Icon(Icons.email),
                                    ),
                                    validator: (value) =>
                                        !(value?.contains('@') ?? false)
                                            ? 'Masukan email yang valid'
                                            : null,
                                    onSaved: (value) => _email = value ?? '',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    right: 30,
                                    left: 30,
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      labelText: "Password",
                                      hintText: "Masukkan password",
                                      prefixIcon: const Icon(Icons.lock),
                                    ),
                                    validator: (value) => value!.length < 8
                                        ? 'Password harus lebih dari 8 karakter'
                                        : null,
                                    onSaved: (value) => _password = value ?? '',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    right: 30,
                                    left: 30,
                                    bottom: 10,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _submit,
                                    child: const Text('Login'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final response = await http.post(
            Uri.parse("http://spklu.solusi-rnd.tech/api/login"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"email": _email, "password": _password}));
        var results = jsonDecode(response.body);
        print(response.body);
        if (results["success"] == true) {
          if (results["user"]["active"] == "1") {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('api_token', results['user']['api_token']);
            prefs.setInt('id', results['user']['id']);
            print(prefs.setString('api_token', results['user']['api_token']));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const NavigationPage(
                          uuid: '',
                        )),
                (route) => false);
          } else {
            // showCupertinoAlertDialog(context, "Alert!",
            //     "Your account is not active, please contact the administrator");
          }
        } else {
          // dangerAlert(context);
          print('eror');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
