import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/banner_ad_widget.dart';
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
                const BannerAdWidget(),
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
