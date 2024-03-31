import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getSnapshotStream(String agentName, String mapName, String siteName) {
    return FirebaseFirestore.instance
        .collection('lineups')
        .doc(agentName)
        .collection(mapName)
        .doc(siteName)
        .snapshots();
  }
}
