import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:travel_app/screens/LoginScreen.dart';

class post_app_bar extends StatefulWidget {
  final String favoriPlaceId;

  post_app_bar({required this.favoriPlaceId});

  @override
  _PostAppBarState createState() => _PostAppBarState();
}

class _PostAppBarState extends State<post_app_bar> {
  bool isFavori = false;

  @override
  void initState() {
    super.initState();
    //checkFavoriStatus();
    toggleFavori();
  }

  Future<void> checkFavoriStatus() async {
    var headers = {
      'X-APIKEY': '1234',
      'PKEY': 'NSK',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "UserName": Login.PublicUsername,
      "FavoriPlaceId": widget.favoriPlaceId,
    });
    try {
      var dio = Dio();
      var response = await dio.post(
        'https://nsk.neyfer.tech/favoriAddOrDelete',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      print(response.data["data"]);
      setState(() {
        isFavori = response.data["data"];
      });
    } catch (e) {
      print("Favori durumu kontrolünde hata: $e");
    }
  }

  Future<void> toggleFavori() async {
    var headers = {
      'X-APIKEY': '1234',
      'PKEY': 'NSK',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "UserName": Login.PublicUsername,
      "FavoriPlaceId": widget.favoriPlaceId,
    });

    try {
      var dio = Dio();
      var response = await dio.post(
        'https://nsk.neyfer.tech/toggleFavori',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      setState(() {
        isFavori = response.data["data"];
      });
    } catch (e) {
      print("Favori durumu güncellemede hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              checkFavoriStatus();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: isFavori
                  ? Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 28,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: 28,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
