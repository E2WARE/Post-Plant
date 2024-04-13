import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/splash_screen.dart';
import 'package:postplantlineup/views/utils/banner_ad_widget.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const BannerAdWidget bannerAdWidget = BannerAdWidget();
  bannerAdWidget.createState().initState();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'post-plant',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: CustomColors.primaryColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: CustomColors.textColor),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: CustomColors.primaryColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: CustomColors.textColor),
        ),
      ),
      home: const Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SplashScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
