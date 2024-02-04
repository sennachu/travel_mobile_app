import 'package:flutter/material.dart';
import 'package:travel_app/screens/postScreen.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final String cityGuid;
  final String photo;
  final String puan;
  final String Aciklama;
  final double lat;
  final double lon;
  const CityCard({
    Key? key,
    required this.cityName,
    required this.cityGuid,
    required this.photo,
    required this.puan,
    required this.Aciklama,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => postScreen(
                photo: photo,
                text: cityName,
                puan: puan,
                Aciklama: Aciklama,
                lat: lat,
                lon: lon,
                Guid: cityGuid),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(
          left: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(photo),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                cityName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
