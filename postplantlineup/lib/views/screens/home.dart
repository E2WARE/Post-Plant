import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/main_grid_view_widget.dart';
import '../widgets/main_image_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anasayfa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ImageWidget(),
          Expanded(
            child: Container(
              color: CustomColors.primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: GridViewWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
