import 'package:flutter/material.dart';
import '../data/lineups_data_service.dart';
import '../models/lineups_model.dart';

class LineupViewModel extends ChangeNotifier {
  List<Lineup> _lineups = [];
  List<Lineup> get lineups => _lineups;

  Stream<List<Lineup>> fetchLineupsStream(String agentName, String mapName) {
    return FirebaseServiceGetData.getLineupsStream(agentName, mapName)
      ..listen((lineups) {
        _lineups = lineups;
        notifyListeners();
      });
  }
}
