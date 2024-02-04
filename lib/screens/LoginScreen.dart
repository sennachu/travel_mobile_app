import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/homeScreen.dart';
import 'package:travel_app/screens/registerScreen.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  static String PublicUsername = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Giriş Yap',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
            ElevatedButton(
              onPressed: () async {
                var headers = {
                  'X-APIKEY': '1234',
                  'PKEY': 'NSK',
                  'Content-Type': 'application/json'
                };
                var data = json.encode({
                  "UserEmail": emailController.text,
                  "UserPassword": passwordController.text
                });

                try {
                  var dio = Dio();
                  dio.interceptors.add(
                      LogInterceptor(responseBody: true, requestBody: true));
                  var response = await dio.post(
                    'https://nsk.neyfer.tech/checklogin',
                    options: Options(
                      headers: headers,
                    ),
                    data: data,
                  );

                  if (response.statusCode == 200) {
                    final List<dynamic> responseDataDistrictList =
                        response.data['data'];

                    bool isUserLoggedIn = responseDataDistrictList
                        .any((element) => element['UserName'] != null);

                    if (isUserLoggedIn) {
                      Login.PublicUsername =
                          responseDataDistrictList[0]["UserName"];

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => homeScreen()),
                      );
                    } else {
                      print('Giriş başarısız');
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                'Giriş Yap',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                "Kayıt ol",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
