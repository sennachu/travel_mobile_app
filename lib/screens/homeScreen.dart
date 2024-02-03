import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/widgets/CityCard.dart';
import 'package:travel_app/widgets/CustomCard.dart';

import 'package:travel_app/widgets/home_bottom_bar.dart';
import '../widgets/home_app_bar.dart';
import 'package:dio/dio.dart';

class homeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homeScreen> {
  List<Map<String, dynamic>> categorys = [];
  List<Map<String, dynamic>> places = [];
  List<Map<String, dynamic>> districts = [];
  var dio = Dio();
  var headers = {
    'X-APIKEY': '1234',
    'PKEY': 'NSK',
    'Content-Type': 'application/json'
  };
  Future<void> fetchData() async {
    var response = await dio.get(
      'https://nsk.neyfer.tech/placeTypeList',
      options: Options(headers: headers),
    );
    var responseplaceList = await dio.get(
      'https://nsk.neyfer.tech/placeList',
      options: Options(headers: headers),
    );
    var responseDistrictList = await dio.get(
      'https://nsk.neyfer.tech/districtList',
      options: Options(headers: headers),
    );
    if (responseDistrictList.statusCode == 200) {
      final List<dynamic> responseDataDistrictList =
          responseDistrictList.data['data'];

      setState(() {
        districts = responseDataDistrictList.cast<Map<String, dynamic>>();
      });
    }
    if (responseplaceList.statusCode == 200) {
      final List<dynamic> responseDataPlaceList =
          responseplaceList.data['data'];

      setState(() {
        places = responseDataPlaceList.cast<Map<String, dynamic>>();
      });
    }
    if (response.statusCode == 200) {
      final List<dynamic> responseDataList = response.data['data'];

      setState(() {
        categorys = responseDataList.cast<Map<String, dynamic>>();
      });
    }
  }

  Future<void> fetchCategoryDetails(String PlaceTypeGuid) async {
    var data = json.encode({"PlaceType": "${PlaceTypeGuid}"});
    var responseplaceList = await dio.post(
      'https://nsk.neyfer.tech/PlaceListForId',
      options: Options(headers: headers),
      data: data,
    );
    if (responseplaceList.statusCode == 200) {
      final List<dynamic> responseDataPlaceList =
          responseplaceList.data['data'];

      setState(() {
        places = responseDataPlaceList.cast<Map<String, dynamic>>();
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
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (Map<String, dynamic> district in districts)
                          CityCard(
                            photo: district["DistrictImage"],
                            cityName: district["DistrictName"],
                            puan: district["DistrictRate"].toString(),
                            Aciklama: district["DistrictDescription"],
                            lat: district["DistrictLat"],
                            lon: district["DistrictLon"],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          for (Map<String, dynamic> category in categorys)
                            GestureDetector(
                              onTap: () {
                                fetchCategoryDetails(category["PlaceTypeGuid"]);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  category["PlaceTypeName"],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (Map<String, dynamic> place in places)
                    CustomCard(
                      photo: place["PlaceImage"],
                      text: place["PlaceName"],
                      puan: place["PlaceRate"].toString(),
                      Aciklama: place["PlaceDescription"],
                      lat: place["PlaceLat"],
                      lon: place["PlaceLon"],
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
