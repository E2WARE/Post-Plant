import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postplantlineup/views/utils/google_ads.dart';
import '../utils/colors.dart';
import '../../data/agents_data_service.dart';
import '../../models/agents_model.dart';
import '../utils/slide_page_route.dart';
import '../widgets/agents_grid_view_widget.dart';
import 'home.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  final GoogleAds _googleAds = GoogleAds();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _showInitialInterstitialAd();
    _googleAds.loadBannerAd();
    _timer = Timer.periodic(const Duration(minutes: 3), (timer) {
      _showInterstitialAd();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showInitialInterstitialAd() {
    _googleAds.loadInterstitalAd(showAfterLoad: true);
  }

  void _showInterstitialAd() {
    _googleAds.loadInterstitalAd(showAfterLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder<List<Agent>>(
      future: AgentsDataService().getAgents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Agents',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: CustomColors.primaryColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    SlidePageRoute(page: const HomePage()),
                  );
                },
              ),
            ),
            backgroundColor: CustomColors.primaryColor,
            body: Column(
              children: [
                Expanded(
                  child: AgentsGridViewWidget(
                    agents: snapshot.data!,
                    onAgentSelected: (String agentName) {
                      // Handle agent selection
                    },
                  ),
                ),
                Container(
                  height: 60,
                  width: 468,
                  color: CustomColors.primaryColor,
                  child: AdWidget(ad: _googleAds.bannerAd),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
