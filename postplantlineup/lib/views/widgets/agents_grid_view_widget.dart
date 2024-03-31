// agents_grid_view_widget.dart

import 'package:flutter/material.dart';
import '../../models/agents_model.dart';
import '../../view_models/agents_view_model.dart';
import 'agent_card_widget.dart';

class AgentsGridViewWidget extends StatelessWidget {
  final List<Agent> agents;
  final Function(String) onAgentSelected;

  const AgentsGridViewWidget({
    super.key,
    required this.agents,
    required this.onAgentSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GridView.count(
      crossAxisCount: size.width > 600 ? 4 : 2,
      crossAxisSpacing: size.width * 0.02,
      mainAxisSpacing: size.width * 0.02,
      childAspectRatio: 1.3 / 2,
      children: agents.map((agent) {
        return AgentCardWidget(
          viewModel: AgentCardViewModel(
            agent: agent,
            onAgentSelected: onAgentSelected,
          ),
        );
      }).toList(),
    );
  }
}
