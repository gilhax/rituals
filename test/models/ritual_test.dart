import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rituals/models/ritual.dart';

void main() {
  group('Ritual', () {
    test('should serialize to JSON correctly', () {
      const ritual = Ritual(
        id: '123',
        title: 'Morning Meditation',
        description: 'Meditate for 10 minutes',
        time: TimeOfDay(hour: 8, minute: 30),
      );

      final json = ritual.toJson();

      expect(json['id'], '123');
      expect(json['title'], 'Morning Meditation');
      expect(json['description'], 'Meditate for 10 minutes');
      expect(json['hour'], 8);
      expect(json['minute'], 30);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': '123',
        'title': 'Morning Meditation',
        'description': 'Meditate for 10 minutes',
        'hour': 8,
        'minute': 30,
      };

      final ritual = Ritual.fromJson(json);

      expect(ritual.id, '123');
      expect(ritual.title, 'Morning Meditation');
      expect(ritual.description, 'Meditate for 10 minutes');
      expect(ritual.time.hour, 8);
      expect(ritual.time.minute, 30);
    });

    test('should format time correctly', () {
      const morningRitual = Ritual(
        id: '1',
        title: 'Morning',
        description: '',
        time: TimeOfDay(hour: 8, minute: 30),
      );

      const afternoonRitual = Ritual(
        id: '2',
        title: 'Afternoon',
        description: '',
        time: TimeOfDay(hour: 14, minute: 45),
      );

      const midnightRitual = Ritual(
        id: '3',
        title: 'Midnight',
        description: '',
        time: TimeOfDay(hour: 0, minute: 0),
      );

      expect(morningRitual.formattedTime, '8:30 AM');
      expect(afternoonRitual.formattedTime, '2:45 PM');
      expect(midnightRitual.formattedTime, '12:00 AM');
    });

    test('should create copy with updated fields', () {
      const original = Ritual(
        id: '123',
        title: 'Original',
        description: 'Original description',
        time: TimeOfDay(hour: 8, minute: 0),
      );

      final updated = original.copyWith(
        title: 'Updated',
        time: const TimeOfDay(hour: 9, minute: 0),
      );

      expect(updated.id, '123');
      expect(updated.title, 'Updated');
      expect(updated.description, 'Original description');
      expect(updated.time.hour, 9);
    });

    test('should handle empty description', () {
      final json = {
        'id': '123',
        'title': 'Test',
        'hour': 8,
        'minute': 0,
      };

      final ritual = Ritual.fromJson(json);

      expect(ritual.description, '');
    });
  });
}
