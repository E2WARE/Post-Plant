import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postplantlineup/models/sites_model.dart';
import 'package:postplantlineup/views/screens/maps.dart';
import '../utils/colors.dart';
import '../../data/site_data_service.dart';
import '../../view_models/agents_view_model.dart';
import '../../view_models/map_view_model.dart';
import '../utils/slide_page_route.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder<List<SiteModel>>(
      future: SitesDataService().getSites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sites',
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
                    SlidePageRoute(
                        page: MapsPage(agentCardViewModel: agentCardViewModel)),
                  );
                },
              ),
            ),
            backgroundColor: CustomColors.primaryColor,
            body: SitesGridViewWidget(
              sites: snapshot.data!,
              onSiteSelected: (String siteName) {},
              agentCardViewModel: agentCardViewModel,
              mapCardViewModel: mapCardViewModel,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        // Handle the case when neither data nor error is present
        return const Center(
          child: Text('No data available'),
        );
      },
    );
  }}