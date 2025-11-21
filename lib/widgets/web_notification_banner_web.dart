import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Banner to inform web users about notification permissions
class WebNotificationBanner extends StatefulWidget {
  const WebNotificationBanner({super.key});

  @override
  State<WebNotificationBanner> createState() => _WebNotificationBannerState();
}

class _WebNotificationBannerState extends State<WebNotificationBanner> {
  bool _showHelpBanner = true;

  @override
  Widget build(BuildContext context) {
    // Only show on web and if notifications are denied or not supported
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    if (!html.Notification.supported) {
      return _buildErrorBanner(
        'Notifications Not Supported',
        'Your browser does not support notifications. Please try a modern browser like Chrome, Firefox, or Safari.',
      );
    }

    if (html.Notification.permission == 'denied') {
      return _buildErrorBanner(
        'Notifications Blocked',
        'You have blocked notifications. To enable them, click the lock icon in your browser\'s address bar and allow notifications.',
      );
    }

    // Show helpful tip if permission is granted
    if (html.Notification.permission == 'granted' && _showHelpBanner) {
      return _buildInfoBanner(
        '💡 Notification Tip',
        'Browser notifications only appear when this tab is minimized or in the background. Minimize this tab to see your ritual notifications!',
        onDismiss: () {
          setState(() {
            _showHelpBanner = false;
          });
        },
      );
    }

    // Don't show banner if permission is default (we'll request on startup)
    return const SizedBox.shrink();
  }

  Widget _buildErrorBanner(String title, String message) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing2),
      padding: const EdgeInsets.all(AppTheme.spacing2),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.amber, size: 20),
          const SizedBox(width: AppTheme.spacing2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner(String title, String message,
      {VoidCallback? onDismiss}) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing2),
      padding: const EdgeInsets.all(AppTheme.spacing2),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.blue, size: 20),
          const SizedBox(width: AppTheme.spacing2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: AppTheme.spacing1),
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              color: Colors.blue[700],
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              tooltip: 'Dismiss',
            ),
          ],
        ],
      ),
    );
  }
}
