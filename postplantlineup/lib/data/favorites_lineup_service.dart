import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lineups_model.dart';

class FavoriteLineupService {
  static const _key = 'favoriteLineups';

  static Future<List<Map<String, dynamic>>> getFavoriteLineups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? lineupJsons = prefs.getStringList(_key);
    if (lineupJsons == null) {
      return [];
    }
    try {
      return lineupJsons.map((jsonString) {
        try {
          return json.decode(jsonString) as Map<String, dynamic>;
        } catch (e) {
          return null;
        }
      }).where((item) => item != null).cast<Map<String, dynamic>>().toList();
    } catch (e) {
      return [];
    }
  }



  static Future<void> toggleFavoriteLineup(Lineup lineup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favorites = await getFavoriteLineups();
    bool isFavorite = false;

    for (int i = 0; i < favorites.length; i++) {
      if (favorites[i]['lineupName'] == lineup.lineupName) {
        favorites.removeAt(i);
        isFavorite = true;
        break;
      }
    }

    if (!isFavorite) {
      favorites.add({
        'lineupName': lineup.lineupName,
        'lineupDescription': lineup.lineupDescription,
        'lineupImageUrl': lineup.lineupImageUrl,
        'siteName': lineup.siteName,
      });
    }

    await prefs.setStringList(
        _key, favorites.map((lineup) => json.encode(lineup)).toList());
  }

  static Future<bool> isLineupFavorite(Lineup lineup) async {
    List<Map<String, dynamic>> favorites = await getFavoriteLineups();
    return favorites.any((fav) => fav['lineupName'] == lineup.lineupName);
  }
}
