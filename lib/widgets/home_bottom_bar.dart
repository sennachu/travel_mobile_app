import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/screens/FavoritesScreen.dart';
import 'package:travel_app/screens/LocationScreen.dart';
import 'package:travel_app/screens/LoginScreen.dart';
import 'package:travel_app/screens/homeScreen.dart';

class HomeBottomBar extends StatefulWidget {
  @override
  _HomeBottomBarState createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _selectedIndex = 1; // Başlangıçta "Home" iconu seçili olsun

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        // Sayfa geçişini burada yapın
        switch (_selectedIndex) {
          case 0:
            // Favoriler sayfasına yönlendir
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritesScreen()),
            );
            break;
          case 1:
            // Ana sayfaya yönlendir
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homeScreen()),
            );
            break;
          case 2:
            // Konum sayfasına yönlendir
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationScreen()),
            );
            break;
          case 3:
            if (Login.PublicUsername == "") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
              break;
            }
          default:
            break;
        }
      },
      items: [
        Icon(
          Icons.favorite,
          size: 30,
          color: _selectedIndex == 0 ? Colors.redAccent : null,
        ),
        Icon(
          Icons.home,
          size: 30,
          color: _selectedIndex == 1 ? Colors.redAccent : null,
        ),
        Icon(
          Icons.location_on,
          size: 30,
          color: _selectedIndex == 2 ? Colors.redAccent : null,
        ),
        Visibility(
          visible: Login.PublicUsername == "" || Login.PublicUsername.isEmpty,
          child: Icon(
            Login.PublicUsername == ""
                ? Icons.supervised_user_circle
                : Icons.verified,
            size: 30,
            color: _selectedIndex == 2
                ? Login.PublicUsername == ""
                    ? Colors.redAccent
                    : Colors.green
                : null,
          ),
        ),
      ],
    );
  }
}
