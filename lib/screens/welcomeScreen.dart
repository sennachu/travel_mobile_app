import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:travel_app/screens/LoginScreen.dart';
import 'package:travel_app/screens/homeScreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late String backgroundImage = "";
  late Color FullTextColor = Colors.white;

  late Color buttonColor = Colors.white;
  late String TextHeader = "";
  late String TextSub = "";

  /*Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/welcome-data'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        backgroundImage = data['backgroundImage'];
        enjoyTextColor = _parseColor(data['enjoyTextColor']);
        worldTextColor = _parseColor(data['worldTextColor']);
        descriptionTextColor = _parseColor(data['descriptionTextColor']);
        buttonColor = _parseColor(data['buttonColor']);
      });
    } else {
      // Hata durumunda işlemler
      print('API request failed with status: ${response.statusCode}');
    }
  }
*/
  var dio = Dio();
  var headers = {'X-APIKEY': '1234', 'PKEY': 'NSK'};
  Future<void> fetchData() async {
    var response = await dio.get(
      'https://nsk.neyfer.tech/loginImageList',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseDataDistrictList = response.data['data'];

      setState(() {
        backgroundImage = responseDataDistrictList[0]["Image"].toString();
        FullTextColor = parseColor(
            responseDataDistrictList[0]["ImageTextColor"].toString());
      });
    }
  }

  Color parseColor(String colorHex) {
    // Renk kodu uygun mu kontrol et
    if (colorHex == null || !(colorHex.length == 7 || colorHex.length == 9)) {
      // Varsayılan renk olarak beyazı dön
      return Colors.white;
    }

    // Renk kodunu renk nesnesine dönüştür
    return Color(int.parse(colorHex.substring(1), radix: 16) | 0xFF000000);
  }

  @override
  void initState() {
    backgroundImage = "https://mfiles.alphacoders.com/597/597930.jpg";
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundImage),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 65, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Istanbul",
                  style: TextStyle(
                    color: FullTextColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Bir Başka Güzel",
                  style: TextStyle(
                    color: FullTextColor.withOpacity(0.9),
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Doğunun mistik dokusunu, batının çağdaşlığıyla birleştiren bu eşsiz şehir, köprüleriyle sadece kıtaları değil, kültürleri de birbirine bağlar. ",
                  style: TextStyle(
                    color: FullTextColor.withOpacity(0.7),
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Ink(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}
