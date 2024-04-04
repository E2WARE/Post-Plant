import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Siyah arkaplan
      body: Center(
        child: Image.asset(
          'assets/splash/image.png',
          width: MediaQuery.of(context).size.width * 0.5, // Ekran genişliğinin yarısı kadar
          height: MediaQuery.of(context).size.height * 0.5, // Ekran yüksekliğinin yarısı kadar
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
