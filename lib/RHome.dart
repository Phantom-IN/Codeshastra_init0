import 'package:code/Applicants.dart';
import 'package:code/CreateJob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:simple_icons/simple_icons.dart';

class RHome extends StatefulWidget {
  const RHome({super.key});

  @override
  State<RHome> createState() => _RHomeState();
}

class _RHomeState extends State<RHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CreateJob(),
    Applicants()
  ];

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: GNav(
          gap: 5,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 60, right: 60),
          onTabChange: _onTabChange,
          tabs: [
            GButton(
              icon: CupertinoIcons.briefcase_fill,
              text: "Jobs",
            ),
            GButton(
              icon: CupertinoIcons.profile_circled,
              text: "Maps",
            ),
          ],
          selectedIndex: _currentIndex,
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          Positioned(
            top: 65,
            left: 20,
            child: FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              child: Icon(Icons.menu, color: Color(0xFF83aabc)),
              backgroundColor: Color(0xFFeaf3ff),
            ),
          ),
        ],
      ),
    );
  }
}
