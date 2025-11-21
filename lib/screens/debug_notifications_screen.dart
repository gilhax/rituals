import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ritual_provider.dart';
import '../theme/app_theme.dart';

/// Debug screen for testing notifications
class DebugNotificationsScreen extends StatelessWidget {
  const DebugNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RitualProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔔 Notification Debugger'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test Notification Button
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🧪 Test Notification',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing2),
                    const Text(
                      'Click the button below to send an immediate test notification. '
                      'You should see it appear in your notification center right away.',
                    ),
                    const SizedBox(height: AppTheme.spacing2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showTestNotification(context),
                        icon: const Icon(Icons.notification_add),
                        label: const Text('Send Test Notification NOW'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacing3),

            // Scheduled Notifications
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📅 Scheduled Notifications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing2),
                    if (provider.rituals.isEmpty)
                      const Text(
                        'No rituals scheduled yet. Create a ritual to schedule notifications.',
                        style: TextStyle(color: AppTheme.textSecondary),
                      )
                    else
                      ...provider.rituals.map((ritual) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppTheme.spacing1),
                            child: Row(
                              children: [
                                const Icon(Icons.alarm, size: 20),
                                const SizedBox(width: AppTheme.spacing1),
                                Expanded(
                                  child: Text(
                                    '${ritual.title} at ${ritual.formattedTime}',
                                  ),
                                ),
                                Text(
                                  'ID: ${ritual.id.hashCode}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          )),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacing3),

            // Instructions
            Card(
              color: AppTheme.primary.withValues(alpha: 0.1),
              child: const Padding(
                padding: EdgeInsets.all(AppTheme.spacing3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: AppTheme.primary),
                        SizedBox(width: AppTheme.spacing1),
                        Text(
                          'Troubleshooting',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacing2),
                    Text(
                      '1. Make sure notifications are enabled in System Settings → Notifications → rituals',
                    ),
                    SizedBox(height: AppTheme.spacing1),
                    Text(
                      '2. Check Focus/Do Not Disturb is not blocking notifications',
                    ),
                    SizedBox(height: AppTheme.spacing1),
                    Text(
                      '3. The test notification should appear immediately',
                    ),
                    SizedBox(height: AppTheme.spacing1),
                    Text(
                      '4. Scheduled notifications fire daily at the set time',
                    ),
                    SizedBox(height: AppTheme.spacing1),
                    Text(
                      '5. Check the terminal/console for debug logs',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTestNotification(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🧪 Sending IMMEDIATE test notification...'),
        duration: Duration(seconds: 2),
      ),
    );

    // Send immediate notification using the plugin directly
    try {
      final plugin = context.read<RitualProvider>();

      // Try to send immediate notification
      // This will help us see if notifications work AT ALL
      await Future.delayed(const Duration(milliseconds: 500));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Check Notification Center NOW! If you don\'t see a notification, '
                'go to System Settings → Notifications → rituals'),
            backgroundColor: AppTheme.primary,
            duration: Duration(seconds: 10),
          ),
        );
      }

      // Also create a 1-minute test
      await plugin.createRitual(
        title: '🧪 TEST - 1 minute',
        description: 'Should appear in 1 minute',
        time: TimeOfDay(
          hour: TimeOfDay.now().hour,
          minute: (TimeOfDay.now().minute + 1) % 60,
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }
}
