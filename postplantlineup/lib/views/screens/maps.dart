import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../data/map_data_service.dart';
import '../../models/maps_model.dart';
import '../../view_models/agents_view_model.dart';
import '../widgets/maps_grid_view_widget.dart';

class MapsPage extends StatelessWidget {
  final AgentCardViewModel agentCardViewModel;

  const MapsPage({super.key,
    required this.agentCardViewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MapModel>>(
      future: MapsDataService().getMaps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Maps',
            home: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Maps',
                  style: TextStyle(color : CustomColors.textColor),
                ),
                backgroundColor: CustomColors.primaryColor,
              ),
              backgroundColor: CustomColors.primaryColor,
              body: MapsGridViewWidget(
                maps: snapshot.data!,
                onMapSelected: (String mapName) {},
                agentCardViewModel: agentCardViewModel,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('No data'),
            ),
          ),
        );
      },
    );
  }
}
