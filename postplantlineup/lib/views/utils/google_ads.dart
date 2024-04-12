import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAds{
  InterstitialAd? _interstitialAd;
  late BannerAd bannerAd;

  void loadInterstitalAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            if(showAfterLoad){
              showInterstitalAd();
            }
          },
          onAdFailedToLoad: (LoadAdError error) {
          },
        ));
  }

  void showInterstitalAd(){
    if(_interstitialAd!=null){
      _interstitialAd!.show();
    }
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }
}