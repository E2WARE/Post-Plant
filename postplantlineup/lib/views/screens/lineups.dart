import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postplantlineup/views/screens/sites_dart.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import 'package:postplantlineup/view_models/site_view_model.dart';
import '../../data/lineups_data_service.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/map_view_model.dart';
import '../utils/lineups_cardList.dart';
import '../utils/slide_page_route.dart';
import 'lineups_full_screen.dart';

class LineupPage extends StatelessWidget {
  final AgentCardViewModel agentCardViewModel;
  final MapCardViewModel mapCardViewModel;
  final SiteCardViewModel siteCardViewModel;

  const LineupPage({
    super.key,
    required this.agentCardViewModel,
    required this.mapCardViewModel,
    required this.siteCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final agentName = agentCardViewModel.agent.name;
    final mapName = mapCardViewModel.mapName;
    final siteName = siteCardViewModel.site.siteName;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lineups',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Ana sayfaya animasyonlu geçiş
            Navigator.pushReplacement(
              context,
              SlidePageRoute(page: SitesPage(agentCardViewModel: agentCardViewModel, mapCardViewModel: mapCardViewModel)),
            );
          },
        ),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseServiceGetData.getSnapshotStream(agentName, mapName, siteName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              return const Text('No data available');
            } else {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              return _buildGrid(data, context);
            }
          },
        ),
      ),
      backgroundColor: CustomColors.primaryColor,
    );
  }

  Widget _buildGrid(Map<String, dynamic> data, BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: buildCards(data, (urls) => _showImageDialog(context, urls)),
    );
  }

  void _showImageDialog(BuildContext context, List<String> urls) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImagePage(
          urls: urls,
          agentName: agentCardViewModel.agent.name,
          mapName: mapCardViewModel.mapName,
          siteName: siteCardViewModel.site.siteName,
        ),
      ),
    );
  }
}
