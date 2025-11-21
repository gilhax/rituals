import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/ritual.dart';
import '../repositories/ritual_repository.dart';
import '../services/notification_service_interface.dart';

/// State provider for rituals with CRUD operations
class RitualProvider extends ChangeNotifier {
  final RitualRepository _repository;
  final INotificationService _notificationService;
  final _uuid = const Uuid();

  List<Ritual> _rituals = [];
  bool _isLoading = false;
  String? _error;

  List<Ritual> get rituals => List.unmodifiable(_rituals);
  bool get isLoading => _isLoading;
  String? get error => _error;

  RitualProvider(this._repository, this._notificationService);

  /// Load all rituals from storage
  Future<void> loadRituals() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _rituals = await _repository.getAll();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Create a new ritual
  Future<void> createRitual({
    required String title,
    required String description,
    required TimeOfDay time,
  }) async {
    _error = null;

    try {
      final ritual = Ritual(
        id: _uuid.v4(),
        title: title,
        description: description,
        time: time,
      );

      await _repository.save(ritual);
      await _notificationService.scheduleNotification(ritual);
      await loadRituals();
    } catch (e) {
      _error = 'Failed to create ritual: $e';
      notifyListeners();
      rethrow;
    }
  }

  /// Update an existing ritual
  Future<void> updateRitual(Ritual ritual) async {
    _error = null;

    try {
      await _repository.save(ritual);
      await _notificationService.scheduleNotification(ritual);
      await loadRituals();
    } catch (e) {
      _error = 'Failed to update ritual: $e';
      notifyListeners();
      rethrow;
    }
  }

  /// Delete a ritual
  Future<void> deleteRitual(String id) async {
    _error = null;

    try {
      await _repository.delete(id);
      await _notificationService.cancelNotification(id);
      await loadRituals();
    } catch (e) {
      _error = 'Failed to delete ritual: $e';
      notifyListeners();
      rethrow;
    }
  }

  /// Get ritual by ID
  Ritual? getRitualById(String id) {
    try {
      return _rituals.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
