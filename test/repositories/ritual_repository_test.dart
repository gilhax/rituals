import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rituals/models/ritual.dart';
import 'package:rituals/repositories/ritual_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('RitualRepository', () {
    late RitualRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      repository = RitualRepository(prefs);
    });

    test('should return empty list when no rituals exist', () async {
      final rituals = await repository.getAll();
      expect(rituals, isEmpty);
    });

    test('should save and retrieve a ritual', () async {
      const ritual = Ritual(
        id: '123',
        title: 'Test Ritual',
        description: 'Test Description',
        time: TimeOfDay(hour: 8, minute: 0),
      );

      await repository.save(ritual);
      final rituals = await repository.getAll();

      expect(rituals, hasLength(1));
      expect(rituals.first.id, '123');
      expect(rituals.first.title, 'Test Ritual');
    });

    test('should update existing ritual', () async {
      const ritual = Ritual(
        id: '123',
        title: 'Original',
        description: 'Original Description',
        time: TimeOfDay(hour: 8, minute: 0),
      );

      await repository.save(ritual);

      final updated = ritual.copyWith(title: 'Updated');
      await repository.save(updated);

      final rituals = await repository.getAll();
      expect(rituals, hasLength(1));
      expect(rituals.first.title, 'Updated');
    });

    test('should delete ritual', () async {
      const ritual = Ritual(
        id: '123',
        title: 'Test',
        description: '',
        time: TimeOfDay(hour: 8, minute: 0),
      );

      await repository.save(ritual);
      await repository.delete('123');

      final rituals = await repository.getAll();
      expect(rituals, isEmpty);
    });

    test('should return null when ritual not found', () async {
      final ritual = await repository.getById('nonexistent');
      expect(ritual, isNull);
    });

    test('should sort rituals by time', () async {
      const morning = Ritual(
        id: '1',
        title: 'Morning',
        description: '',
        time: TimeOfDay(hour: 8, minute: 0),
      );

      const evening = Ritual(
        id: '2',
        title: 'Evening',
        description: '',
        time: TimeOfDay(hour: 20, minute: 0),
      );

      const afternoon = Ritual(
        id: '3',
        title: 'Afternoon',
        description: '',
        time: TimeOfDay(hour: 14, minute: 30),
      );

      // Save in random order
      await repository.save(evening);
      await repository.save(morning);
      await repository.save(afternoon);

      final rituals = await repository.getAll();

      expect(rituals, hasLength(3));
      expect(rituals[0].title, 'Morning'); // 8:00
      expect(rituals[1].title, 'Afternoon'); // 14:30
      expect(rituals[2].title, 'Evening'); // 20:00
    });

    test('should handle multiple rituals', () async {
      for (int i = 0; i < 10; i++) {
        await repository.save(
          Ritual(
            id: 'ritual_$i',
            title: 'Ritual $i',
            description: 'Description $i',
            time: TimeOfDay(hour: i % 24, minute: 0),
          ),
        );
      }

      final rituals = await repository.getAll();
      expect(rituals, hasLength(10));
    });

    test('should handle empty description', () async {
      const ritual = Ritual(
        id: '123',
        title: 'No Description',
        description: '',
        time: TimeOfDay(hour: 8, minute: 0),
      );

      await repository.save(ritual);
      final retrieved = await repository.getById('123');

      expect(retrieved, isNotNull);
      expect(retrieved!.description, '');
    });
  });
}
