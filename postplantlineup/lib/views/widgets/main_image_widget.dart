import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      decoration: const BoxDecoration(
        color: CustomColors.primaryColor,
        gradient: LinearGradient(
          colors: [
            CustomColors.accentColor,
            CustomColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.39, 0.39],
        ),
      ),
      child: Image.asset(
        'assets/agent_images/Brimstone.jpeg',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
