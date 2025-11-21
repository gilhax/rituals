import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ritual.dart';

/// Repository for managing ritual data in local storage
class RitualRepository {
  static const String _storageKey = 'rituals';
  final SharedPreferences _prefs;

  RitualRepository(this._prefs);

  /// Get all rituals, sorted by time
  /// Throws: Exception if storage read fails
  Future<List<Ritual>> getAll() async {
    try {
      final String? jsonString = _prefs.getString(_storageKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString) as List;
      final rituals = jsonList
          .map((json) => Ritual.fromJson(json as Map<String, dynamic>))
          .toList();

      // Sort by time (hour, then minute)
      rituals.sort((a, b) {
        final hourCompare = a.time.hour.compareTo(b.time.hour);
        if (hourCompare != 0) return hourCompare;
        return a.time.minute.compareTo(b.time.minute);
      });

      return rituals;
    } catch (e) {
      throw Exception('Failed to load rituals: $e');
    }
  }

  /// Save a ritual (create or update)
  /// Throws: Exception if storage write fails
  Future<void> save(Ritual ritual) async {
    try {
      final rituals = await getAll();

      // Remove existing ritual with same ID if updating
      rituals.removeWhere((r) => r.id == ritual.id);

      // Add ritual
      rituals.add(ritual);

      // Save to storage
      final jsonList = rituals.map((r) => r.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await _prefs.setString(_storageKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save ritual: $e');
    }
  }

  /// Delete ritual by ID
  /// Throws: Exception if storage write fails
  Future<void> delete(String id) async {
    try {
      final rituals = await getAll();
      rituals.removeWhere((r) => r.id == id);

      final jsonList = rituals.map((r) => r.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await _prefs.setString(_storageKey, jsonString);
    } catch (e) {
      throw Exception('Failed to delete ritual: $e');
    }
  }

  /// Get single ritual by ID
  /// Returns: null if not found
  Future<Ritual?> getById(String id) async {
    try {
      final rituals = await getAll();
      return rituals.where((r) => r.id == id).firstOrNull;
    } catch (e) {
      return null;
    }
  }
}
