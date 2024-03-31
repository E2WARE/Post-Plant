import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/maps_model.dart';

class MapsDataService {
  Future<List<MapModel>> getMaps() async {
    String jsonString =
    await rootBundle.loadString('assets/json_datas/maps_data.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((map) {
      String mapName = map['mapName'] ?? '';
      String imagePath = map['imagePath'] ?? '';
      return MapModel(mapName: mapName, imagePath: imagePath);
    }).toList();
  }
}

