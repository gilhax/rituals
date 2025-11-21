import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ritual_provider.dart';
import '../widgets/ritual_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/web_notification_banner.dart';
import 'ritual_detail_screen.dart';
import 'ritual_form_screen.dart';
import 'debug_notifications_screen.dart';
import '../theme/app_theme.dart';

/// Main screen displaying list of all rituals
class RitualListScreen extends StatelessWidget {
  const RitualListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rituals'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Debug Notifications',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DebugNotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<RitualProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.error,
                  ),
                  const SizedBox(height: AppTheme.spacing2),
                  Text(
                    'Failed to load rituals',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTheme.spacing1),
                  Text(
                    provider.error!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacing3),
                  ElevatedButton(
                    onPressed: () {
                      provider.clearError();
                      provider.loadRituals();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.rituals.isEmpty) {
            return const EmptyState();
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadRituals(),
            child: Column(
              children: [
                const WebNotificationBanner(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppTheme.spacing2),
                    itemCount: provider.rituals.length,
                    itemBuilder: (context, index) {
                      final ritual = provider.rituals[index];
                      return RitualCard(
                        ritual: ritual,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  RitualDetailScreen(ritualId: ritual.id),
                            ),
                          );
                        },
                        onEdit: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RitualFormScreen(ritual: ritual),
                            ),
                          );
                        },
                        onDelete: () async {
                          // Delete directly - confirmDismiss already handled confirmation
                          await context
                              .read<RitualProvider>()
                              .deleteRitual(ritual.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const RitualFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
