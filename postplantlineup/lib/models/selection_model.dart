class SelectionModel {
  String selectedAgent = '';
  String selectedMap = '';
  String selectedSite = '';

  void setSelections(String agentName, String mapName, String siteName) {
    selectedAgent = agentName;
    selectedMap = mapName;
    selectedSite = siteName;
  }
}