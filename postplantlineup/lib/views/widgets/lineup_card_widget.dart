import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/lineups_full_screen.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import 'package:postplantlineup/views/utils/google_ads.dart';
import '../../models/lineups_model.dart';

class LineupCardWidget extends StatefulWidget {
  final Lineup lineup;
  final List<String> imageUrls;

  const LineupCardWidget({
    super.key,
    required this.lineup,
    required this.imageUrls,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LineupCardWidgetState createState() => _LineupCardWidgetState();
}

class _LineupCardWidgetState extends State<LineupCardWidget> {
  late Timer _adTimer;
  bool _adShown = false;

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(const Duration(minutes: 3), (timer) {
      setState(() {
        _adShown = false;
      });
    });
  }

  @override
  void dispose() {
    _adTimer.cancel();
    super.dispose();
  }

  void _showInterstitialAd() {
    if (!_adShown) {
      GoogleAds().loadInterstitalAd(showAfterLoad: true);
      setState(() {
        _adShown = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (!_adShown) {
          _showInterstitialAd();
        }
        _navigateToFullScreenPage();
      },

      child: Card(
        elevation: 4,
        color: CustomColors.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.03),
          side: const BorderSide(color: CustomColors.accentColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                child: Image.network(
                  widget.lineup.lineupImageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.textColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: size.width * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Text(
                widget.lineup.lineupName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.044,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFullScreenPage() {
    List<String> imageUrls = widget.lineup.lineupImageUrl.split(" , ");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(
          imageUrls: imageUrls,
          description: widget.lineup.lineupDescription,
        ),
      ),
    );
  }
}
