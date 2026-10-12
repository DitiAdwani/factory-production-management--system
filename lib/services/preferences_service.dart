import 'package:cloud_firestore/cloud_firestore.dart';

class PreferencesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> saveList(String key, List<String> data) async {
    await _firestore.collection("dropdowns").doc(key).set({"values": data});
  }

  static Future<List<String>> loadList(String key) async {
    final doc = await _firestore.collection("dropdowns").doc(key).get();

    if (!doc.exists) return [];

    return List<String>.from(doc["values"]);
  }
}
