import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/agents_model.dart';

class AgentsDataService {
  Future<List<Agent>> getAgents() async {
    String jsonString = await rootBundle.loadString('assets/json_datas/agents_data.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse
        .map((agent) => Agent(name: agent['name'], imagePath: agent['imagePath']))
        .toList();
  }
}