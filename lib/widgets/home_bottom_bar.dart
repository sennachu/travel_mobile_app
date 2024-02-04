import 'package:flutter/material.dart';
import 'package:travel_app/screens/FavoritesScreen.dart';
import 'package:travel_app/screens/LocationScreen.dart';
import 'package:travel_app/screens/LoginScreen.dart';
import 'package:travel_app/screens/homeScreen.dart';

class HomeBottomBar extends StatefulWidget {
  @override
  _HomeBottomBarState createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _selectedIndex = 1; // Başlangıçta "Home" sayfası seçili olsun

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Seçilen indeksi güncelle
    });

    switch (index) {
      case 0:
        // Favoriler sayfasına yönlendir
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FavoritesScreen()),
        );
        break;
      case 1:
        // Ana sayfaya yönlendir
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => homeScreen()),
        );
        break;
      case 2:
        // Konum sayfasına yönlendir
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LocationScreen()),
        );
        break;
      case 3:
        // Çıkış yap
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Color.fromARGB(0, 255, 82, 82),
      backgroundColor: Colors.transparent,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline, size: 30, color: Colors.black45),
          label: 'Favorites',
        ), // index 0
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30, color: Colors.black45),
          label: 'Home',
        ), // index 1
        BottomNavigationBarItem(
          icon:
              Icon(Icons.location_on_outlined, size: 30, color: Colors.black45),
          label: 'Location',
        ), //index 2
        BottomNavigationBarItem(
          icon: Icon(Icons.logout_outlined, size: 30, color: Colors.black45),
          label: 'Logout',
        ), //index 3
      ],
    );
  }
}
