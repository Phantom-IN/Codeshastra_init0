import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'Home.dart';
import 'Menu.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
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
