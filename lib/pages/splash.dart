import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_apis/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash_pic.jpg',
              fit: BoxFit.cover,
              width: width * .9,
              height: height * .5,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              'Top Headlines',
              style: GoogleFonts.anton(
                  letterSpacing: .6, color: Colors.grey.shade700),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            const SpinKitChasingDots(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
