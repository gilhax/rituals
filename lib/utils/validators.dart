import 'package:flutter/material.dart';

/// Input validation utilities
class Validators {
  /// Validate ritual title
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }

    if (value.trim().length < 2) {
      return 'Title must be at least 2 characters';
    }

    if (value.length > 60) {
      return 'Title must be less than 60 characters';
    }

    return null;
  }

  /// Validate ritual description
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Description is optional
    }

    if (value.length > 500) {
      return 'Description must be less than 500 characters';
    }

    return null;
  }

  /// Sanitize text input
  static String sanitize(String input) {
    return input.trim();
  }

  /// Check if time is in the future (for immediate notification)
  static bool isTimeInFuture(TimeOfDay time) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    return selectedDateTime.isAfter(now);
  }

  /// Format remaining time until next occurrence
  static String formatTimeUntil(TimeOfDay time) {
    final now = DateTime.now();
    var selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (selectedDateTime.isBefore(now)) {
      selectedDateTime = selectedDateTime.add(const Duration(days: 1));
    }

    final duration = selectedDateTime.difference(now);

    if (duration.inHours > 0) {
      return 'in ${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return 'in ${duration.inMinutes}m';
    }
  }
}
