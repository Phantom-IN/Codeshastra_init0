import 'package:code/ChatBot.dart';
import 'package:code/Connection.dart';
import 'package:code/JobListing.dart';
import 'package:code/Map.dart';
import 'package:code/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    JobListing(),
    Maps(),
    Connection(),
    ChatBot(),
    Profile()
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
          padding: EdgeInsets.all(16),
          onTabChange: _onTabChange,
          tabs: [
            GButton(
              icon: CupertinoIcons.mail_solid,
              text: "Jobs",
            ),
            GButton(
              icon: CupertinoIcons.map_fill,
              text: "Maps",
            ),
            GButton(
              icon: CupertinoIcons.link,
              text: "Connect",
            ),
            GButton(
              icon: CupertinoIcons.chat_bubble_2_fill,
              text: "ChatBot",
            ),
            GButton(
              icon: CupertinoIcons.profile_circled,
              text: "Profile",
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
