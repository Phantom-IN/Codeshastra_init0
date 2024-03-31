// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController linkedinController = TextEditingController();
//   final TextEditingController githubController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();

//   String? _nameError;

//   void _submitForm() {
//     String name = nameController.text;
//     String phone = phoneController.text;
//     String linkedin = linkedinController.text;
//     String github = githubController.text;
//     int age = int.tryParse(ageController.text) ?? 0;

//     // Validation
//     setState(() {
//       _nameError = _validateName(name);
//     });

//     if (_nameError == null) {
//       // Save data to Firestore
//       FirebaseFirestore.instance.collection('users').add({
//         'name': name,
//         'phone': phone,
//         'linkedin': linkedin,
//         'github': github,
//         'age': age,
//       }).then((value) {
//         print('User data saved successfully!');
//         // Clear the form after saving data
//         nameController.clear();
//         phoneController.clear();
//         linkedinController.clear();
//         githubController.clear();
//         ageController.clear();
//       }).catchError((error) {
//         print('Failed to save user data: $error');
//       });
//     }
//   }

//   String? _validateName(String value) {
//     if (value.isEmpty) {
//       return 'Please enter your name';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),
//             TextField(
//               style: TextStyle(color: Colors.black),
//               controller: nameController,
//               cursorColor: Colors.white24,
//               decoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: _nameError != null ? Colors.red : Colors.black,
//                     width: 2.0,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white24, width: 2.0),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                     width: 2.0,
//                   ),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                     width: 2.0,
//                   ),
//                 ),
//                 labelText: 'Enter your name',
//                 labelStyle: TextStyle(
//                   color: _nameError != null ? Colors.red : Colors.black,
//                   fontFamily: "crete",
//                 ),
//                 floatingLabelStyle: TextStyle(
//                   color: _nameError != null ? Colors.red : Colors.black,
//                   fontFamily: "crete",
//                 ),
//                 errorText: _nameError,
//                 suffixIcon: Icon(Icons.person),
//                 suffixIconColor: MaterialStateColor.resolveWith(
//                   (states) => states.contains(MaterialState.focused)
//                       ? (_nameError != null ? Colors.red : Colors.black)
//                       : Colors.white24,
//                 ),
//               ),
//             ),
//             // Other input fields go here similarly
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitForm,
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home1.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController eduController = TextEditingController();


  String? _nameError;
  String? _phoneError;
  String? _linkedinError;
  String? _githubError;
  String? _ageError;
  String? _interestError;
  String? _eduError;

  void _submitForm() {
    String name = nameController.text;
    String phone = phoneController.text;
    String linkedin = linkedinController.text;
    String github = githubController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    String interest = interestController.text;
    String edu = eduController.text;

    setState(() {
      _nameError = _validateName(name);
      _phoneError = _validatePhone(phone);
      _linkedinError = _validateURL(linkedin);
      _githubError = _validateURL(github);
      _ageError = _validateAge(age);
      _interestError = _validateInterest(interest);
      _eduError = _validateEdu(edu);

    });

    if (_nameError == null &&
        _phoneError == null &&
        _linkedinError == null &&
        _githubError == null &&
        _ageError == null &&
        _interestError == null &&
        _eduError == null) {
      FirebaseFirestore.instance.collection('users').doc(widget.uid).set({
        'name': name,
        'phone': phone,
        'linkedin': linkedin,
        'github': github,
        'age': age,
        'interest': interest,
        'edu': edu
      }).then((value) async {

        try {
          // Save form data in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', name);
          prefs.setString('phone', phone);
          prefs.setString('linkedin', linkedin);
          prefs.setString('github', github);
          prefs.setInt('age', age);
          prefs.setString('interest', interest);
          prefs.setString('edu', edu);

          // Navigate to Home1
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home1()),
          );
        } catch (error) {
          print('Error saving data to SharedPreferences: $error');
        }

        print('User data saved successfully!');
        nameController.clear();
        phoneController.clear();
        linkedinController.clear();
        githubController.clear();
        ageController.clear();
        interestController.clear();
        eduController.clear();
      }).catchError((error) {
        print('Failed to save user data: $error');
      });
    }
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateInterest(String value) {
    if (value.isEmpty) {
      return 'Please enter your Interests';
    }
    return null;
  }


  String? _validateEdu(String value) {
    if (value.isEmpty) {
      return 'Please enter your Education';
    }
    return null;
  }


  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  String? _validateURL(String value) {
    if (value.isNotEmpty && !Uri.parse(value).isAbsolute) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  String? _validateAge(int value) {
    if (value <= 0) {
      return 'Please enter a valid age';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage("assets/profile.png"),
              width: double.infinity,
            ),
            SizedBox(height: 15),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: nameController,
              cursorColor: Colors.grey[600],
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _nameError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your name',
                labelStyle: TextStyle(
                    color: _nameError != null ? Colors.red : Colors.black,
                    fontFamily: "crete",
                    fontSize: 16),
                floatingLabelStyle: TextStyle(
                    color: _nameError != null ? Colors.red : Colors.black,
                    fontFamily: "crete",
                    fontSize: 16),
                errorText: _nameError,
                suffixIcon: Icon(Icons.person),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_nameError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: phoneController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _phoneError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your phone number',
                labelStyle: TextStyle(
                  color: _phoneError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                floatingLabelStyle: TextStyle(
                  color: _phoneError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                errorText: _phoneError,
                suffixIcon: Icon(Icons.phone),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_phoneError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: linkedinController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _linkedinError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your LinkedIn URL',
                labelStyle: TextStyle(
                  color: _linkedinError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                floatingLabelStyle: TextStyle(
                  color: _linkedinError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                errorText: _linkedinError,
                suffixIcon: Icon(Icons.link),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_linkedinError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: githubController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _githubError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your GitHub URL',
                labelStyle: TextStyle(
                  color: _githubError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                floatingLabelStyle: TextStyle(
                  color: _githubError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                errorText: _githubError,
                suffixIcon: Icon(Icons.link),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_githubError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: ageController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _ageError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your age',
                labelStyle: TextStyle(
                  color: _ageError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                floatingLabelStyle: TextStyle(
                    color: _ageError != null ? Colors.red : Colors.black,
                    fontFamily: "crete",
                    fontSize: 16),
                errorText: _ageError,
                suffixIcon: Icon(Icons.calendar_today),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_ageError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: interestController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _interestError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your age',
                labelStyle: TextStyle(
                  color: _interestError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                floatingLabelStyle: TextStyle(
                    color: _interestError != null ? Colors.red : Colors.black,
                    fontFamily: "crete",
                    fontSize: 16),
                errorText: _interestError,
                suffixIcon: Icon(Icons.interests),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_interestError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.black),
              controller: eduController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _eduError != null ? Colors.red : Colors.black,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                  ),
                ),
                labelText: 'Enter your age',
                labelStyle: TextStyle(
                  color: _eduError != null ? Colors.red : Colors.black,
                  fontFamily: "crete",
                  fontSize: 16,
                ),
                floatingLabelStyle: TextStyle(
                    color: _eduError != null ? Colors.red : Colors.black,
                    fontFamily: "crete",
                    fontSize: 16),
                errorText: _eduError,
                suffixIcon: Icon(Icons.cast_for_education),
                suffixIconColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.focused)
                      ? (_eduError != null ? Colors.red : Colors.black)
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}