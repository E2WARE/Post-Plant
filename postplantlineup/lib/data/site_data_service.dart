import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/sites_model.dart';

class SitesDataService {
  Future<List<SiteModel>> getSites() async {
    String jsonString =
    await rootBundle.loadString('assets/json_datas/sites_data.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((map) {
      String siteName = map['siteName'] ?? '';
      String imagePath = map['imagePath'] ?? '';
      return SiteModel(siteName: siteName, imagePath: imagePath);
    }).toList();
  }
}

