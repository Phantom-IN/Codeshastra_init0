import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_icons/simple_icons.dart';

import 'main.dart';

class Menu2 extends StatefulWidget {
  const Menu2({super.key});

  @override
  State<Menu2> createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> {

  String? Name;

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';

    setState(() {
      Name = name;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF83aabc),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                child: const Icon(Icons.close,color: Color(0xFF83aabc),), // Replace with your desired icon
                backgroundColor: const Color(0xFFeaf3ff), // Change the background color as needed
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                Name?.isNotEmpty == true ? Name! : 'Welcome User',
                style: TextStyle(fontFamily: "crete", fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(
                Icons.home,color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "crete"
                ),
              ),
              onTap: (){
                ZoomDrawer.of(context)!.toggle();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,color: Colors.white,
              ),
              title: Text(
                "Account",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "crete"
                ),
              ),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(
                Icons.star,color: Colors.white,
              ),
              title: Text(
                "Rating",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "crete"
                ),
              ),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,color: Colors.white,
              ),
              title: Text(
                "About",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "crete"
                ),
              ),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip, color: Colors.white,
              ),
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "crete"
                ),
              ),
              onTap: ()  {

              },
            ),
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Confirm Logout",
                        style: TextStyle(
                            fontFamily: "crete"
                        ),
                      ),
                      content: const Text("Are you sure you want to log out?",
                        style: TextStyle(
                            fontFamily: "crete"
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "crete"
                            ),),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF83aabc),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Splash()),
                            );
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(fontFamily: "crete"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(50.0, 50.0),  // Set the width and height to the same value
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.0),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Color(0xFF83aabc),
                      fontFamily: "crete",
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
