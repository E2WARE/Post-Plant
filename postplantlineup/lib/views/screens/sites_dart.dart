import 'package:flutter/material.dart';
import 'package:postplantlineup/models/sites_model.dart';
import '../utils/colors.dart';
import '../../data/site_data_service.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/map_view_model.dart';
import '../widgets/sites_grid_view_widget.dart';

class SitesPage extends StatelessWidget {
  final AgentCardViewModel agentCardViewModel;
  final MapCardViewModel mapCardViewModel;

  const SitesPage({
    super.key,
    required this.agentCardViewModel,
    required this.mapCardViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SiteModel>>(
      future: SitesDataService().getSites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sites',
            home: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Sites',
                  style: TextStyle(color: CustomColors.textColor),
                ),
                backgroundColor: CustomColors.primaryColor,
              ),
              backgroundColor: CustomColors.primaryColor,
              body: SitesGridViewWidget(
                sites: snapshot.data!,
                onSiteSelected: (String siteName) {},
                agentCardViewModel: agentCardViewModel,
                mapCardViewModel: mapCardViewModel,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        }
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
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
