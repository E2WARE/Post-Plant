import 'package:flutter/material.dart';
import 'package:postplantlineup/views/screens/maps.dart';
import '../../data/lineups_data_service.dart';
import '../../models/lineups_model.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/map_view_model.dart';
import '../utils/colors.dart';
import '../utils/slide_page_route.dart';
import '../widgets/lineups_grid_view_widget.dart';

class LineupPage extends StatelessWidget {
  final AgentCardViewModel agentCardViewModel;
  final MapCardViewModel mapCardViewModel;

  const LineupPage({
    super.key,
    required this.agentCardViewModel,
    required this.mapCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final agentName = agentCardViewModel.agent.name;
    final mapName = mapCardViewModel.mapName;

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
            Navigator.pushReplacement(
              context,
              SlidePageRoute(page:  MapsPage(agentCardViewModel: agentCardViewModel)),
            );
          },
        ),
      ),
      backgroundColor: CustomColors.primaryColor,
      body: StreamBuilder<List<Lineup>>(
        stream: FirebaseServiceGetData.getLineupsStream(agentName, mapName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No lineups available.'),
            );
          }
          return LineupGridViewWidget(
            lineups: snapshot.data!,
          );
        },
      ),
    );
  }
}
