import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFFF65959),
              ),
              Text(
                "  İstanbul, Türkiye",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                  onPressed: () {
                    //EMAİL GÖNDERME KODLARI PATH YAZAN KISIMDA SİZİN MAİLİNİZE GELECEGİ VE KONU OLARAK DA UYGULAMA HAKKINDA BİR YORUMUM VAR YAZAR
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: '222016746@stu.istinye.edu.tr',
                      query: encodeQueryParameters(<String, String>{
                        'subject': "Uygulama Hakkında Bir Yorumum Var",
                      }),
                    );

                    launchUrl(emailLaunchUri);
                  },
                  icon: Icon(Icons.mail_outline, size: 21)),
            ),
          ),
        ],
      ),
    );
  }
}
