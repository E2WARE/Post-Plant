import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../../data/agents_data_service.dart';
import '../../models/agents_model.dart';
import '../widgets/agents_grid_view_widget.dart';

class AgentsPage extends StatelessWidget {
  const AgentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Agent>>(
      future: AgentsDataService().getAgents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'post-plant',
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: CustomColors.primaryColor,
              textTheme: const TextTheme(
                bodyText1: TextStyle(color: CustomColors.textColor),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: CustomColors.primaryColor,
              textTheme: const TextTheme(
                bodyText1: TextStyle(color: CustomColors.textColor),
              ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Agents',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: CustomColors.primaryColor,
              ),
              backgroundColor: CustomColors.primaryColor,
              body: AgentsGridViewWidget(
                agents: snapshot.data!,
                onAgentSelected: (String agentName) {
                  // Handle agent selection
                },
              ),
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
