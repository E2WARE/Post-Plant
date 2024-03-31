import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/main_model.dart';

class CardData {
  static Future<List<CardModel>> getCards() async {
    String jsonString =
    await rootBundle.loadString('assets/json_datas/card_data.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse
        .map((card) => CardModel.fromJson(card))
        .toList();
  }
}