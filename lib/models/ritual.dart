import 'package:flutter/material.dart';

/// Represents a daily ritual with scheduled notification
class Ritual {
  final String id;
  final String title;
  final String description;
  final TimeOfDay time;

  const Ritual({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
  });

  /// Serialize to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'hour': time.hour,
      'minute': time.minute,
    };
  }

  /// Deserialize from JSON
  factory Ritual.fromJson(Map<String, dynamic> json) {
    return Ritual(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      time: TimeOfDay(
        hour: json['hour'] as int,
        minute: json['minute'] as int,
      ),
    );
  }

  /// Create a copy with optional field updates
  Ritual copyWith({
    String? id,
    String? title,
    String? description,
    TimeOfDay? time,
  }) {
    return Ritual(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  /// Format time for display (e.g., "09:30 AM")
  String get formattedTime {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ritual && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
