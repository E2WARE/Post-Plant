import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/home.dart';
import 'package:postplantlineup/views/utils/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainPage());
}
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'post-plant',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: CustomColors.primaryColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: CustomColors.textColor),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: CustomColors.primaryColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: CustomColors.textColor),
        ),
      ),
      home: const HomePage(),
    );
  }
}