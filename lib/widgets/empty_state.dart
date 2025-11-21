import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Empty state widget shown when no rituals exist
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny_outlined,
              size: 80,
              color: AppTheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppTheme.spacing3),
            Text(
              'No rituals yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.spacing1),
            Text(
              'Start your first one by tapping the + button',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
