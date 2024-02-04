import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:travel_app/screens/LoginScreen.dart';

import 'dart:convert';

import 'package:travel_app/widgets/map_Screen.dart';

class post_bottom_bar extends StatelessWidget {
  final String photo;
  final String name;
  final String puan;
  final String Aciklama;
  final double lat;
  final double lon;
  final String Guid;
  final VoidCallback? onShareBusinessInfo;

  const post_bottom_bar({
    Key? key,
    required this.photo,
    required this.name,
    required this.puan,
    required this.Aciklama,
    required this.lat,
    required this.lon,
    required this.Guid,
    this.onShareBusinessInfo,
  }) : super(key: key);
  Future<void> sendBusinessInfo() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFEDF2F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25,
                        ),
                        Text(
                          puan,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              Aciklama,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            width: 450,
            height: 200,
            child: MapScreen(
              initialLatitude: lat,
              initialLongitude: lon,
              initialzoom: 15,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 75,
          ),
          SizedBox(
            height: 90,
          ),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var dio = Dio();

                    var headersAPI = {
                      'X-APIKEY': '1234',
                      'PKEY': 'NSK',
                      'Content-Type': 'application/json'
                    };
                    var data = json.encode({"UserName": Login.PublicUsername});
                    var response = await dio.request(
                      'https://nsk.neyfer.tech/getPhoneNumber',
                      options: Options(
                        method: 'POST',
                        headers: headersAPI,
                      ),
                      data: data,
                    );
                    var PhoneNumber = response.data["data"];
                    try {
                      var headers = {
                        'Authorization': 'Basic cHJzOlByczc4NDVQcnMhKg=='
                      };

                      var response = await dio.request(
                        'http://34.71.251.75:9000/api/Functions/SendImageWithWP?WPPhoneNumber=${PhoneNumber}&MsgContent=Mekan Bilgileri:%20%5CnAdı: ${name} 🏰%20%5CnAçıklaması: ${Aciklama} 📝%20%5CnPuanı: ${puan} ⭐️&ImageUrl=${photo}',
                        options: Options(
                          method: 'POST',
                          headers: headers,
                        ),
                      );
                    } catch (e) {
                      print("Error: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black26,
                    elevation: 4,
                  ),
                  child: Text(
                    "İşletme Bilgilerini Paylaş",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
