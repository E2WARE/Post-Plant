import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lineups_model.dart';

class FirebaseServiceGetData {
  static Stream<List<Lineup>> getLineupsStream(String agentName, String mapName) {
    return FirebaseFirestore.instance
        .collection('lineups')
        .doc(agentName)
        .collection(mapName)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final data = doc.data();
      return Lineup(
        lineupName: data['lineupName'] ?? '',
        lineupDescription: data['lineupDescription'] ?? '',
        lineupImageUrl: data['lineupImageUrls'] ?? '',
        siteName: data['siteName'] ?? '',
      );
    }).toList());
  }
}
