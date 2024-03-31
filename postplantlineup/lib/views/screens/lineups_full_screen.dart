import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<String> urls;

  const FullScreenImagePage({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return Image.network(
            urls[index],
            fit: BoxFit.contain, // Resmi ekran boyutuna sığdır
          );
        },
      ),
    );
  }
}
