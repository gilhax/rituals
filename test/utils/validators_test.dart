import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rituals/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateTitle', () {
      test('should return error for null', () {
        expect(Validators.validateTitle(null), isNotNull);
      });

      test('should return error for empty string', () {
        expect(Validators.validateTitle(''), isNotNull);
      });

      test('should return error for whitespace only', () {
        expect(Validators.validateTitle('   '), isNotNull);
      });

      test('should return error for single character', () {
        expect(Validators.validateTitle('A'), isNotNull);
      });

      test('should return null for valid title', () {
        expect(Validators.validateTitle('Morning Meditation'), isNull);
      });

      test('should return error for title over 60 chars', () {
        final longTitle = 'A' * 61;
        expect(Validators.validateTitle(longTitle), isNotNull);
      });

      test('should return null for title at 60 chars', () {
        final maxTitle = 'A' * 60;
        expect(Validators.validateTitle(maxTitle), isNull);
      });
    });

    group('validateDescription', () {
      test('should return null for null (optional)', () {
        expect(Validators.validateDescription(null), isNull);
      });

      test('should return null for empty string (optional)', () {
        expect(Validators.validateDescription(''), isNull);
      });

      test('should return null for valid description', () {
        expect(
          Validators.validateDescription('Meditate for 10 minutes'),
          isNull,
        );
      });

      test('should return error for description over 500 chars', () {
        final longDesc = 'A' * 501;
        expect(Validators.validateDescription(longDesc), isNotNull);
      });
    });

    group('sanitize', () {
      test('should trim whitespace', () {
        expect(Validators.sanitize('  test  '), 'test');
      });

      test('should handle empty string', () {
        expect(Validators.sanitize(''), '');
      });

      test('should preserve internal spaces', () {
        expect(Validators.sanitize('  hello world  '), 'hello world');
      });
    });

    group('isTimeInFuture', () {
      test('should return true for time in future', () {
        final now = TimeOfDay.now();
        final future = TimeOfDay(
          hour: (now.hour + 1) % 24,
          minute: now.minute,
        );
        // This test might fail if run exactly at 23:xx, but acceptable for unit test
        if (now.hour < 23) {
          expect(Validators.isTimeInFuture(future), isTrue);
        }
      });

      test('should return false for time in past', () {
        final now = TimeOfDay.now();
        if (now.hour > 0) {
          final past = TimeOfDay(
            hour: now.hour - 1,
            minute: now.minute,
          );
          expect(Validators.isTimeInFuture(past), isFalse);
        }
      });
    });
  });
}
