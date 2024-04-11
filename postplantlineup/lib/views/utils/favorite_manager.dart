import 'package:shared_preferences/shared_preferences.dart';
import '../../models/lineups_model.dart';

class FavoriteManager {
  static Future<bool> isFavorite(Lineup lineup) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool favoriteStatus = prefs.getBool('favorite_${lineup.lineupName}') ?? false;
    bool favoriteStatusUrl = prefs.getBool('favorite_${lineup.lineupImageUrl}') ?? false;
    bool favoriteStatusDesc = prefs.getBool('favorite_${lineup.lineupDescription}') ?? false;
    return favoriteStatus && favoriteStatusUrl && favoriteStatusDesc;
  }

  static Future<void> toggleFavorite(Lineup lineup) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCurrentlyFavorite = await isFavorite(lineup);
    bool newFavoriteStatus = !isCurrentlyFavorite;

    await prefs.setBool('favorite_${lineup.lineupName}', newFavoriteStatus);
    await prefs.setBool('favorite_${lineup.lineupImageUrl}', newFavoriteStatus);
    await prefs.setBool('favorite_${lineup.lineupDescription}', newFavoriteStatus);
  }
}
