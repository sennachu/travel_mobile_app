// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:travel_app/widgets/CityCard.dart';
import 'package:travel_app/widgets/CustomCard.dart';
import 'package:travel_app/widgets/home_bottom_bar.dart';
import '../widgets/home_app_bar.dart';

class homeScreen extends StatelessWidget {
  var category = [
    'Best Places',
    'Most Visited',
    'Favourites',
    'New Added',
    'Hotels',
    'Restaurants',
  ];

  @override
  Widget build(BuildContext context) {
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
                        CityCard(
                            cityName: "Maslak", photo: "images/maslak.jpg"),
                        CityCard(cityName: "Avcılar", photo: "images/avc.jpg"),
                        CityCard(cityName: "Kadıköy", photo: "images/kadı.jpg"),
                        CityCard(
                            cityName: "Pendik", photo: "images/pendik.jpg"),
                        CityCard(cityName: "Sarıyer", photo: "images/sar.jpg"),
                        CityCard(cityName: "Beşiktaş", photo: "images/bes.jpg"),
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
                          for (int i = 0; i < 6; i++)
                            Container(
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
                                category[i],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomCard(
                      photo: "images/arboretum.jpg",
                      text: "Atatürk Arboretumu",
                      puan: "4.9"),
                  CustomCard(
                      photo: "images/dbahce.jpg",
                      text: "Dolmabahçe Sarayı",
                      puan: "4.7"),
                  CustomCard(
                      photo: "images/istiklal.jpg",
                      text: "İstiklal Caddesi",
                      puan: "3.4"),
                  CustomCard(
                      photo: "images/kbarlar.jpg",
                      text: "Kadıköy Barlar Sokağı",
                      puan: "2.5"),
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
