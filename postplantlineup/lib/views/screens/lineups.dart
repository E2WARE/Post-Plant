import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:postplantlineup/views/utils/colors.dart';
import 'package:postplantlineup/view_models/site_view_model.dart';
import '../../data/lineups_data_service.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/map_view_model.dart';
import '../utils/lineups_cardList.dart';
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
    final agentName = agentCardViewModel.agent.name;
    final mapName = mapCardViewModel.mapName;
    final siteName = siteCardViewModel.site.siteName;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lineups',
          style: TextStyle(color: CustomColors.textColor),
        ),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseService.getSnapshotStream(agentName, mapName, siteName),
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
        builder: (context) => FullScreenImagePage(urls: urls),
      ),
    );
  }
}
