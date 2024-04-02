import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/home.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late bool _isVideoPlaying;

  @override
  void initState() {
    super.initState();
    _isVideoPlaying = false;
    _controller = VideoPlayerController.asset('assets/splash/isopop.mp4')
      ..initialize().then((_) {
        setState(() {
          // Video oynatma hazır olduğunda, video oynatılabilir duruma geçirilir.
          _isVideoPlaying = true;
          _controller.play();
          _startTimer(); // Video oynatıldığında, süre başlatılır.
        });
      });
  }

  // Ana ekrana geçiş için zamanlayıcı başlatılır.
  void _startTimer() {
    Timer(_controller.value.duration!, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Video arka plana yerleştirilir.
          _isVideoPlaying
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}