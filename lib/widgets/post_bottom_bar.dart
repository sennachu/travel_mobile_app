import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:convert';

import 'package:travel_app/widgets/map_Screen.dart';

class post_bottom_bar extends StatelessWidget {
  final String photo;
  final String name;
  final String puan;
  final String Aciklama;
  final double lat;
  final double lon;
  final VoidCallback? onShareBusinessInfo;

  const post_bottom_bar({
    Key? key,
    required this.photo,
    required this.name,
    required this.puan,
    required this.Aciklama,
    required this.lat,
    required this.lon,
    this.onShareBusinessInfo,
  }) : super(key: key);
  Future<void> sendBusinessInfo() async {
    var headers = {
      'X-APIKEY': '1234',
      'PKEY': 'NSK',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "WPPhoneNumber": "905051539449",
      "MsgContent":
          "Mekan Bilgileri: [NSK] Adı: ${name} 🏰 [NSK] Açıklaması: ${Aciklama} 📝 [NSK] Puanı: ${puan} ⭐️",
      "ImageUrl": photo
    });
    var dio = Dio();

    try {
      var response = await dio.post(
        'https://nsk.neyfer.tech/sendWp',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      print("Response: ${response.data}");
    } catch (e) {
      print("Error: $e");
    }
  }

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
                  onPressed: onShareBusinessInfo,
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
