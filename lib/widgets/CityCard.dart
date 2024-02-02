import 'package:flutter/material.dart';
import 'package:travel_app/screens/postScreen.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final String photo;

  const CityCard({
    Key? key,
    required this.cityName,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => postScreen(),
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
            image: AssetImage(photo), // city1.jpg, city2.jpg, vb. dosya adları
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
