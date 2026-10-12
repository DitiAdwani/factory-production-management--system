import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/saved_entries.dart';

class EntryStorage {
  static const String key = "saved_entries";

  // Load entries
  static Future<List<SavedEntry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    List decoded = jsonDecode(data);

    return decoded.map((e) => SavedEntry.fromMap(e)).toList();
  }

  // Save all entries
  static Future<void> saveEntries(List<SavedEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> data = entries.map((e) => e.toMap()).toList();

    prefs.setString(key, jsonEncode(data));
  }

  // Add one entry
  static Future<void> addEntry(SavedEntry entry) async {
    final entries = await loadEntries();
    entries.add(entry);
    await saveEntries(entries);
  }
}
