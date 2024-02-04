import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/homeScreen.dart';
import 'package:travel_app/screens/loginScreen.dart';
import 'package:travel_app/screens/registerScreen.dart';

void main() {
  runApp(RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  static String PublicUsername = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _RegisterScreen(),
    );
  }
}

class _RegisterScreen extends StatefulWidget {
  @override
  __RegisterScreenState createState() => __RegisterScreenState();
}

class __RegisterScreenState extends State<_RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Kayıt Ol', //
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'İsim',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Soyisim',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifrenizi Onaylayın',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Telefon Numaranız 0 olarak Yazısınız',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(width: 65),
                  ElevatedButton(
                    onPressed: () async {
                      var headers = {
                        'X-APIKEY': '1234',
                        'PKEY': 'NSK',
                        'Content-Type': 'application/json'
                      };
                      var data = json.encode({
                        "UserEmail": emailController.text,
                      });

                      var dio = Dio();
                      dio.interceptors.add(LogInterceptor(
                          responseBody: true, requestBody: true));
                      var response = await dio.post(
                        'https://nsk.neyfer.tech/checkUser',
                        options: Options(
                          headers: headers,
                        ),
                        data: data,
                      );

                      if (response.statusCode == 200) {
                        bool isUserold = response.data['data'];

                        if (isUserold) {
                          showSnackBar(context,
                              "Bu E posta adresi ile bir hesap eşleşiyor.");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                          return;
                        } else {
                          var newUserData = json.encode({
                            "UserName": firstNameController.text,
                            "UserSurname": lastNameController.text,
                            "UserEmail": emailController.text,
                            "UserPassword": passwordController.text,
                            "UserPhone": "9" + phoneController.text
                          });

                          var responsenewuser = await dio.request(
                            'https://nsk.neyfer.tech/addNewUser',
                            options: Options(
                              method: 'POST',
                              headers: headers,
                            ),
                            data: newUserData,
                          );
                          Login.PublicUsername = firstNameController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homeScreen()),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Kayıt ol",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
