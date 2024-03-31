import '../models/agents_model.dart';

class AgentCardViewModel {
  final Agent agent;
  final Function(String) onAgentSelected;
  AgentCardViewModel({required this.agent, required this.onAgentSelected});

  void selectAgent() {
    onAgentSelected(agent.name);
  }
}
