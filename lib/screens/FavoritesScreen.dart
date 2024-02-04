import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/widgets/CustomCard.dart';

import 'package:travel_app/widgets/home_bottom_bar.dart';
import '../widgets/home_app_bar.dart';
import 'package:dio/dio.dart';

import 'LoginScreen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreen createState() => _FavoritesScreen();
}

class _FavoritesScreen extends State<FavoritesScreen> {
  String Username = Login.PublicUsername;
  List<Map<String, dynamic>> FavoriPlaceList = [];
  var dio = Dio();
  var headers = {
    'X-APIKEY': '1234',
    'PKEY': 'NSK',
    'Content-Type': 'application/json'
  };
  Future<void> fetchData() async {
    var data = json.encode({"UserName": Login.PublicUsername});
    var dio = Dio();
    var response = await dio.request(
      'https://nsk.neyfer.tech/favoriList',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseDataPlaceList = response.data['data'];

      setState(() {
        FavoriPlaceList = responseDataPlaceList.cast<Map<String, dynamic>>();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);

    // print(userProvider.userName);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: HomeAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  for (Map<String, dynamic> place in FavoriPlaceList)
                    CustomCard(
                      photo: place["PlaceImage"],
                      text: place["PlaceName"],
                      puan: place["PlaceRate"].toString(),
                      Aciklama: place["PlaceDescription"],
                      lat: place["PlaceLat"],
                      lon: place["PlaceLon"],
                      Guid: place["PlaceGuid"],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
