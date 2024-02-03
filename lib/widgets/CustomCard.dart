import 'package:flutter/material.dart';
import 'package:travel_app/screens/postScreen.dart';

class CustomCard extends StatelessWidget {
  final String photo;
  final String text;
  final String puan;
  final String Aciklama;
  final double lat;
  final double lon;
  const CustomCard({
    Key? key,
    required this.photo,
    required this.text,
    required this.puan,
    required this.Aciklama,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => postScreen(
                    photo: photo,
                    text: text,
                    puan: puan,
                    Aciklama: Aciklama,
                    lat: lat,
                    lon: lon,
                  ),
                ),
              );
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(photo),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              Text(
                puan,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
