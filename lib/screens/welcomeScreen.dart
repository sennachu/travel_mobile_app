import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:travel_app/screens/homeScreen.dart';
import 'package:travel_app/screens/postScreen.dart';

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

  Future<String> postData(String endpoint, Map<dynamic, dynamic> data) async {
    var headers = {'X-APIKEY': '1234', 'PKEY': 'NSK'};
    var dio = Dio();
    var response = await dio.request(
      'https://nsk.neyfer.tech/loginImageList',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return (json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
    return "";
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

  Future<void> _initializeData() async {
    print("çalışıo");
    var model = {};

    final String x = await postData("loginImageList", model);

    // x içindeki veriyi kullanma örneği
    final Map<String, dynamic> responseData = json.decode(x);
    print(responseData["data"][0]["Image"]);
    backgroundImage = responseData["data"][0]["Image"];
    TextHeader = "Test 23";
    FullTextColor = parseColor(responseData["data"][0]["ImageTextColor"]);

    buttonColor = FullTextColor;
  }

  @override
  void initState() {
    backgroundImage = "https://mfiles.alphacoders.com/597/597930.jpg";
    _initializeData();
    super.initState();

    print(backgroundImage);
  }
  /*
            backgroundImage = data['backgroundImage'];
        enjoyTextColor = _parseColor(data['enjoyTextColor']);
        worldTextColor = _parseColor(data['worldTextColor']);
        descriptionTextColor = _parseColor(data['descriptionTextColor']);
        buttonColor = _parseColor(data['buttonColor']);
*/

  //final List<dynamic> data = responseData['data'];
/*
    backgroundImage = "https://i.ibb.co/yXMZQQR/bg.jpg";
    enjoyTextColor = Colors.black;
    worldTextColor = Colors.black;
    descriptionTextColor = Colors.black;
    buttonColor = Colors.black;
  */

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
                        builder: (context) => homeScreen(),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Burada ana ekranın tasarımını oluşturabilirsiniz.
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}
