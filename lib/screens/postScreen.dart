import 'package:flutter/material.dart';
import 'package:travel_app/widgets/post_app_bar.dart';
import 'package:travel_app/widgets/post_bottom_bar.dart';

class postScreen extends StatelessWidget {
  final String photo;
  final String text;
  final String puan;
  final String Aciklama;
  final double lat;
  final double lon;
  final String Guid;
  const postScreen(
      {Key? key,
      required this.photo,
      required this.text,
      required this.puan,
      required this.Aciklama,
      required this.lat,
      required this.lon,
      required this.Guid})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(photo),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: post_app_bar(favoriPlaceId: Guid),
        ),
        bottomNavigationBar: post_bottom_bar(
            photo: photo,
            name: text,
            puan: puan,
            Aciklama: Aciklama,
            lat: lat,
            lon: lon,
            Guid: Guid),
      ),
    );
  }
}
