import 'package:flutter/material.dart';
import '../utils/banner_ad_widget.dart';
import '../utils/colors.dart';

class AdblockPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AdblockPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adblock',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: Stack(
        children: [
          Container(
            color: CustomColors.primaryColor,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Ad Block',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textColor,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Text(
                        'Hello, you can block ads.',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          color: CustomColors.textColor,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          // Add necessary navigation code to go to the donation page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.accentColor,
                          minimumSize: Size(screenSize.width * 0.8, screenSize.height * 0.06),
                        ),
                        child: Text(
                          'Ad Block',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.textColor,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Text(
                        'We can remove their ads in exchange for some support.',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textColor,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Text(
                        'How about an ad-free Postplant and supporting us?',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: CustomColors.textColor,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BannerAdWidget(), // Positioned at the bottom of the screen
          ),
        ],
      ),
    );

  }
}
