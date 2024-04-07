class SelectionModel {
  String selectedAgent = '';
  String selectedMap = '';

  void setSelections(String agentName, String mapName) {
    selectedAgent = agentName;
    selectedMap = mapName;
  }
}