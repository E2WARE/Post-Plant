import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import 'package:postplantlineup/views/utils/google_ads.dart';

class BannerAdWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BannerAdWidget({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final GoogleAds _googleAds = GoogleAds();

  @override
  void initState() {
    super.initState();
    _googleAds.loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      color: CustomColors.primaryColor,
      child: AdWidget(ad: _googleAds.bannerAd),
      key: UniqueKey(), // Move the key parameter to the end
    );
  }
}
