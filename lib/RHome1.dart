import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'Menu2.dart';
import 'RHome.dart';

class RHome1 extends StatefulWidget {
  const RHome1({super.key});

  @override
  State<RHome1> createState() => _RHome1State();
}

class _RHome1State extends State<RHome1> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: Menu2(),
      mainScreen: RHome(),
      borderRadius: 24,
      angle: 0,
      showShadow: true,
      mainScreenScale: 0.1,
      menuBackgroundColor: Color(0xFF83aabc),
    );
  }
}
