import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/CreateProfile.dart';
import 'package:code/Home.dart';
import 'package:code/Home1.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _handleGoogleSignIn() async {
    setState(() {
      _isLoading1 = true;
    });
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult =
        await _auth.signInWithCredential(credential);

        final user = authResult.user;
        if (user != null) {
          String email = user.email ?? '';

          // Check if the email already exists in Firestore
          final usersRef = FirebaseFirestore.instance.collection('users');
          final querySnapshot =
          await usersRef.where('email', isEqualTo: email).get();

          if (querySnapshot.size == 0) {
            // Email doesn't exist in Firestore, so save the data
            final userRef = usersRef.doc(); // Create a new document
            await userRef.set({
              'email': email,
            });
          }

          setState(() {
            _isLoading1 = false;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(uid: usersRef.id),
            ),
          );
        }
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    } finally {
      setState(() {
        _isLoading1 = false;
      });
    }
  }

  bool _isLoading = false;
  bool _isLoading1 = false;
  bool _obscurePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _isFormValid = false;

  String? _email;
  String? _password;

  void _validateForm() {
    setState(() {

      _emailError = _validateEmail(emailController.text.trim());
      _passwordError = _validatePassword(passwordController.text.trim());
      _isFormValid =
          _emailError == null && _passwordError == null;

      if (_isFormValid) {

        _email = emailController.text.trim();
        _password = passwordController.text.trim();
      }
    });
  }

  void _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User already exists. Please login.'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile(uid: '',)),
        );
      } else {
        UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        final user = userCredential.user;
        if (user != null) {
          String uid = user.uid; // Get the UID of the signed-in user

          // Save user data to Firestore
          DocumentReference newUserDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
          await newUserDocRef.set({
            'email': _email,
          });

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email!);

          setState(() {
            _isLoading = false;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Profile(uid: uid)),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), duration: Duration(seconds: 2)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToHome(BuildContext context) {
    _validateForm();

    if (_isFormValid) {
      _registerUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields correctly.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.white, fontFamily: "crete");
    TextStyle linkStyle = TextStyle(color: Color(0xfffbb2f4), fontFamily: "crete");

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF83aabc),
                Color(0xFF83aabc),
                Color(0xFF562a79),
                Color(0xFF562a79),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image(
                image: AssetImage("assets/signup.png"),
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Create New Account",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'crete',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white24,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _emailError != null ? Colors.red : Colors.white,
                          width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24, width: 2.0),
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
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: _emailError != null ? Colors.red : Colors.white24,
                      fontFamily: "crete",
                    ),
                    floatingLabelStyle: TextStyle(
                      color: _emailError != null ? Colors.red : Colors.white,
                      fontFamily: "crete",
                    ),
                    errorText: _emailError,
                    suffixIcon: Icon(Icons.email),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.focused)
                        ? (_emailError != null ? Colors.red : Colors.white)
                        : Colors.white24),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailError = _validateEmail(value);
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: passwordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: _obscurePassword,
                  cursorColor: Colors.white24,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _passwordError != null ? Colors.red : Colors.white,
                          width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24, width: 2.0),
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
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: _passwordError != null ? Colors.red : Colors.white24,
                      fontFamily: "crete",
                    ),
                    floatingLabelStyle: TextStyle(
                      color: _passwordError != null ? Colors.red : Colors.white,
                      fontFamily: "crete",
                    ),
                    errorText: _passwordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: _passwordError != null ? Colors.red : Colors.white24,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _passwordError = _validatePassword(value);
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () => _navigateToHome(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfffbb2f4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: Size(50.0, 50.0),
                  ),
                  child: _isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "crete",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    "-OR-",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "crete",
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Register With",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "crete",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _handleGoogleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfffbb2f4),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: _isLoading1
                            ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/google.png", width: 24, height: 24),
                            SizedBox(width: 10),
                            Text(
                              "Register with Google",
                              style: TextStyle(
                                fontFamily: "crete",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: defaultStyle,
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                        ),
                        TextSpan(
                          style: linkStyle,
                          text: " Login here",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Profile(uid: '',)),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
