import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Accessible card widget with proper semantics
class AccessibleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final String? semanticHint;
  final bool excludeSemantics;

  const AccessibleCard({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );

    if (!excludeSemantics) {
      card = Semantics(
        label: semanticLabel,
        hint: semanticHint,
        button: onTap != null,
        enabled: onTap != null,
        child: card,
      );
    }

    return card;
  }
}

/// Accessible icon button with tooltip
class AccessibleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String label;
  final String? tooltip;
  final Color? color;

  const AccessibleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.label,
    this.tooltip,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      enabled: onPressed != null,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: color,
        tooltip: tooltip ?? label,
      ),
    );
  }
}

/// Accessible text with screen reader support
class AccessibleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final String? semanticLabel;
  final bool header;

  const AccessibleText(
    this.text, {
    super.key,
    this.style,
    this.semanticLabel,
    this.header = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      header: header,
      child: Text(text, style: style),
    );
  }
}

/// Time display with proper accessibility
class AccessibleTimeDisplay extends StatelessWidget {
  final String formattedTime;
  final String? semanticLabel;

  const AccessibleTimeDisplay({
    super.key,
    required this.formattedTime,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    // Convert "8:30 AM" to "8:30 in the morning" for screen readers
    String accessibleTime = formattedTime;
    if (semanticLabel != null) {
      accessibleTime = semanticLabel!;
    } else {
      accessibleTime = formattedTime
          .replaceAll('AM', 'in the morning')
          .replaceAll('PM', 'in the evening');
    }

    return Semantics(
      label: 'Scheduled for $accessibleTime',
      child: Row(
        children: [
          const Icon(
            Icons.access_time,
            size: 16,
            semanticLabel: 'Time',
          ),
          const SizedBox(width: 4),
          Text(formattedTime),
        ],
      ),
    );
  }
}

/// Announce messages to screen readers
void announceToScreenReader(BuildContext context, String message) {
  final view = View.of(context);
  SemanticsService.sendAnnouncement(view, message, TextDirection.ltr);
}

/// Focus management utilities
class FocusHelper {
  /// Request focus on a specific node
  static void requestFocus(FocusNode node) {
    node.requestFocus();
  }

  /// Move focus to next focusable widget
  static void focusNext(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Move focus to previous focusable widget
  static void focusPrevious(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }

  /// Unfocus current widget
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
