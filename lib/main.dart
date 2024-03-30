import 'package:code/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Home1.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds before navigating to the home screen
    Future.delayed(Duration(seconds: 4,milliseconds: 200), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home1(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/job.json',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}


