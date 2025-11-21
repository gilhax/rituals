import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ritual_provider.dart';
import '../theme/app_theme.dart';
import 'ritual_form_screen.dart';

/// Screen showing ritual details with "Done" button
class RitualDetailScreen extends StatefulWidget {
  final String ritualId;

  const RitualDetailScreen({
    super.key,
    required this.ritualId,
  });

  @override
  State<RitualDetailScreen> createState() => _RitualDetailScreenState();
}

class _RitualDetailScreenState extends State<RitualDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _showCheckmark = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RitualProvider>();
    final ritual = provider.getRitualById(widget.ritualId);

    if (ritual == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Ritual not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RitualFormScreen(ritual: ritual),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primary.withValues(alpha: 0.05),
                  AppTheme.background,
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing3,
                      ),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusLarge),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusLarge),
                            boxShadow: AppTheme.cardShadow,
                          ),
                          padding: const EdgeInsets.all(AppTheme.spacing3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                ritual.title,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(height: AppTheme.spacing2),
                              // Time
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: AppTheme.textSecondary,
                                  ),
                                  const SizedBox(width: AppTheme.spacing1),
                                  Text(
                                    ritual.formattedTime,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: AppTheme.captionSize),
                                  ),
                                ],
                              ),
                              // Divider
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppTheme.spacing2,
                                ),
                                child: Divider(color: AppTheme.border),
                              ),
                              // Description
                              Text(
                                ritual.description.isEmpty
                                    ? 'No description'
                                    : ritual.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      height: 1.5,
                                      color: ritual.description.isEmpty
                                          ? AppTheme.textSecondary
                                          : AppTheme.textPrimary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Done button
                Padding(
                  padding: const EdgeInsets.all(AppTheme.spacing4),
                  child: ElevatedButton(
                    onPressed: _handleDone,
                    child: const Text('Mark as Done'),
                  ),
                ),
              ],
            ),
          ),
          // Checkmark overlay
          if (_showCheckmark)
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Center(
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.success,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.success.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  void _handleDone() {
    setState(() {
      _showCheckmark = true;
    });

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _animationController.reverse().then((_) {
          if (mounted) {
            setState(() {
              _showCheckmark = false;
            });
            Navigator.of(context).pop();
          }
        });
      });
    });
  }
}
