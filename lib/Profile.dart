import 'package:code/Home1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_icons/simple_icons.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? Name;

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';

    setState(() {
      Name = name;
    });
  }

  String _getAvatarText(String? name) {
    if (name != null && name.isNotEmpty) {
      List<String> nameParts = name.split(' ');
      if (nameParts.length >= 2) {
        return nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
      } else {
        return nameParts[0][0].toUpperCase() + 'U';
      }
    } else {
      return 'WU';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    String avatarText = _getAvatarText(Name);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            ListView(
              children: [
                Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "crete",
                    fontSize: 40,
                    color: Color(0xFF83aabc),
                  ),
                ),
                SizedBox(height: 30,),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'General Settings',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "crete"
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Color(0xFFeaf3ff),
                              child: Text(
                                avatarText,
                                style: TextStyle(fontSize: 24.0, color: Color(0xFF86b8fe)),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aryan Surve",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "crete",
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            SimpleIcons.github, color: SimpleIconColors.github,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Github",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "crete"
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            SimpleIcons.linkedin, color: SimpleIconColors.linkedin,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Linkedin",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "crete"
                            ),
                          ),
                        ],
                      ),
                    ),
                              ],
                            ),
                            Spacer(),
                            ElevatedButton(style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF83aabc),
                            ),onPressed: () {}, child: Text("Edit",style: TextStyle(fontFamily: "crete"),))
                          ],
                        ),
                        Divider(),
                        _buildSettingRow(
                          'Location Settings',
                          'Manage how your device uses location',
                          Switch(value: true, onChanged: (bool value) {},activeColor: Color(0xFF83aabc),),
                        ),
                        Divider(),
                        _buildSettingRow(
                          'Push Notifications',
                          'Instant alerts from apps',
                          Switch(value: true, onChanged: (bool value) {},activeColor: Color(0xFF83aabc),),
                        ),
                        Divider(),
                        _buildSettingRow(
                          'Email Notifications',
                          'Alerts in your inbox',
                          Switch(value: true, onChanged: (bool value) {},activeColor: Color(0xFF83aabc),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Support',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "crete"
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildSupportRow('Terms and Services', () {}),
                        Divider(),
                        _buildSupportRow('Data Policy', () {}),
                        Divider(),
                        _buildSupportRow('About', () {}),
                        Divider(),
                        _buildSupportRow('Help', () {}),
                        Divider(),
                        _buildSupportRow('Contact Us', () {}),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF83aabc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
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
                              // Clear user data from Shared Preferences
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', false);
                              await prefs.remove('name');
                              await prefs.remove('number');
                              await prefs.remove('uid');
                              await prefs.remove('selectedChips');
                              await prefs.remove('latitude');
                              await prefs.remove('longitude');
                              await prefs.remove('locationName');
                              await prefs.remove('likedCards');

                              // Sign out from Firebase Auth and Google Sign-In (if applicable)
                              await FirebaseAuth.instance.signOut();

                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home1()),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Text('Logout',
                      style: TextStyle(fontFamily: "crete",fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String title, String description, Widget trailing) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "crete"
              ),
            ),
            SizedBox(height: 4.0),
            Text(description,style: TextStyle(fontFamily: "crete",fontSize: 13),),
          ],
        ),
        Spacer(),
        trailing,
      ],
    );
  }

  Widget _buildSupportRow(String title, Function() onPressed) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "crete"
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
