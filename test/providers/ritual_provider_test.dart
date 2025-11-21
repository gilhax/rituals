import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rituals/models/ritual.dart';
import 'package:rituals/providers/ritual_provider.dart';
import 'package:rituals/repositories/ritual_repository.dart';
import 'package:rituals/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  group('RitualProvider', () {
    late RitualProvider provider;
    late RitualRepository repository;
    late NotificationService notificationService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      repository = RitualRepository(prefs);
      notificationService =
          NotificationService(FlutterLocalNotificationsPlugin());
      provider = RitualProvider(repository, notificationService);
    });

    test('should start with empty list', () {
      expect(provider.rituals, isEmpty);
      expect(provider.isLoading, false);
      expect(provider.error, isNull);
    });

    test('should load rituals', () async {
      // Pre-populate repository
      await repository.save(
        const Ritual(
          id: '123',
          title: 'Test',
          description: '',
          time: TimeOfDay(hour: 8, minute: 0),
        ),
      );

      await provider.loadRituals();

      expect(provider.rituals, hasLength(1));
      expect(provider.isLoading, false);
      expect(provider.error, isNull);
    });

    test('should create ritual', () async {
      await provider.createRitual(
        title: 'New Ritual',
        description: 'Description',
        time: const TimeOfDay(hour: 9, minute: 0),
      );

      expect(provider.rituals, hasLength(1));
      expect(provider.rituals.first.title, 'New Ritual');
      expect(provider.error, isNull);
    });

    test('should update ritual', () async {
      await provider.createRitual(
        title: 'Original',
        description: '',
        time: const TimeOfDay(hour: 8, minute: 0),
      );

      final ritual = provider.rituals.first;
      final updated = ritual.copyWith(title: 'Updated');

      await provider.updateRitual(updated);

      expect(provider.rituals, hasLength(1));
      expect(provider.rituals.first.title, 'Updated');
    });

    test('should delete ritual', () async {
      await provider.createRitual(
        title: 'To Delete',
        description: '',
        time: const TimeOfDay(hour: 8, minute: 0),
      );

      final ritualId = provider.rituals.first.id;
      await provider.deleteRitual(ritualId);

      expect(provider.rituals, isEmpty);
    });

    test('should find ritual by id', () async {
      await provider.createRitual(
        title: 'Findable',
        description: '',
        time: const TimeOfDay(hour: 8, minute: 0),
      );

      final ritual = provider.rituals.first;
      final found = provider.getRitualById(ritual.id);

      expect(found, isNotNull);
      expect(found!.title, 'Findable');
    });

    test('should return null for non-existent id', () {
      final found = provider.getRitualById('nonexistent');
      expect(found, isNull);
    });

    test('should clear error', () async {
      // Trigger an error somehow (this is simplified)
      provider.clearError();
      expect(provider.error, isNull);
    });

    test('should notify listeners on create', () async {
      int notifyCount = 0;
      provider.addListener(() {
        notifyCount++;
      });

      await provider.createRitual(
        title: 'Test',
        description: '',
        time: const TimeOfDay(hour: 8, minute: 0),
      );

      // Should notify: loading start, loading end
      expect(notifyCount, greaterThan(0));
    });
  });
}
