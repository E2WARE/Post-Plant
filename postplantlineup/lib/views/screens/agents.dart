import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../../data/agents_data_service.dart';
import '../../models/agents_model.dart';
import '../utils/slide_page_route.dart';
import '../widgets/agents_grid_view_widget.dart';
import 'home.dart';

class AgentsPage extends StatelessWidget {
  const AgentsPage({Key? key});


  @override
  Widget build(BuildContext context) {

    final double appBarFontSize = MediaQuery.of(context).size.width * 0.05;

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
                  // Ana sayfaya animasyonlu geçiş
                  Navigator.pushReplacement(
                    context,
                    SlidePageRoute(page: const HomePage()),
                  );
                },
              ),
            ),
            backgroundColor: CustomColors.primaryColor,
            body: AgentsGridViewWidget(
              agents: snapshot.data!,
              onAgentSelected: (String agentName) {
                // Handle agent selection
              },
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
