import 'package:flutter/material.dart';

import '../utils/colors.dart';

class FullScreenImagePage extends StatelessWidget {
  final List<String> urls;

  const FullScreenImagePage({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        'Lineups',
        style: TextStyle(color : CustomColors.textColor),
      ),
        backgroundColor: CustomColors.primaryColor,
      ),
      backgroundColor: CustomColors.primaryColor,
      body: PageView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 4.0,
            child: Image.network(
              urls[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}