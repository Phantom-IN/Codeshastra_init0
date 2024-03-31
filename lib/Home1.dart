import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
import 'Menu.dart';

class Home1 extends StatefulWidget {

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {

  @override
  void initState() {
    super.initState();
    _printSharedPreferences();
  }

  Future<void> _printSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');
    String? linkedin = prefs.getString('linkedin');
    String? github = prefs.getString('github');
    int? age = prefs.getInt('age');
    String? interest = prefs.getString('interest');
    String? edu = prefs.getString('edu');
    String? email = prefs.getString('email');

    print('Name: $name');
    print('Phone: $phone');
    print('LinkedIn: $linkedin');
    print('GitHub: $github');
    print('Age: $age');
    print('Interest: $interest');
    print('Education: $edu');
    print('Email: $email');
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: Menu(),
      mainScreen: Home(),
      borderRadius: 24,
      angle: 0,
      showShadow: true,
      mainScreenScale: 0.1,
      menuBackgroundColor: Color(0xFF83aabc),
    );
  }
}
