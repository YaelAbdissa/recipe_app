import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, "/main");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/home2.jpg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fitHeight,
          ),
          Opacity(
            opacity: 0.4,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 20,
            left: 20,
            child: Text(
              "Savory &\nSweet",
              style: GoogleFonts.inter(
                fontSize: 42,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                color: Color(0xff00B4BF),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.asset(
                "assets/image5.png",
              ),
            ),
          )
        ],
      ),
    );
  }
}
