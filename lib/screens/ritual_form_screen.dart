import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ritual.dart';
import '../providers/ritual_provider.dart';
import '../theme/app_theme.dart';

/// Screen for creating or editing a ritual
class RitualFormScreen extends StatefulWidget {
  final Ritual? ritual;

  const RitualFormScreen({
    super.key,
    this.ritual,
  });

  @override
  State<RitualFormScreen> createState() => _RitualFormScreenState();
}

class _RitualFormScreenState extends State<RitualFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TimeOfDay _selectedTime;
  bool _isSaving = false;

  bool get _isEditing => widget.ritual != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.ritual?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.ritual?.description ?? '',
    );
    _selectedTime = widget.ritual?.time ?? TimeOfDay.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Ritual' : 'New Ritual'),
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
        leadingWidth: 80,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _handleSave,
            child: Text(
              'Save',
              style: TextStyle(
                color: _isSaving ? AppTheme.textSecondary : AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spacing2),
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  boxShadow: AppTheme.cardShadow,
                ),
                padding: const EdgeInsets.all(AppTheme.spacing3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title field
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppTheme.captionSize,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing1),
                    TextFormField(
                      controller: _titleController,
                      autofocus: !_isEditing,
                      maxLength: 60,
                      decoration: const InputDecoration(
                        hintText: 'e.g., Morning meditation',
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppTheme.spacing3),
                    // Description field
                    Text(
                      'Description (optional)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppTheme.captionSize,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing1),
                    TextFormField(
                      controller: _descriptionController,
                      maxLength: 500,
                      maxLines: 4,
                      minLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'What should you do?',
                        counterText: '',
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: AppTheme.spacing3),
                    // Time picker
                    Text(
                      'Time',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppTheme.captionSize,
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacing1),
                    InkWell(
                      onTap: _handleTimePicker,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacing2),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.border),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusSmall),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatTime(_selectedTime),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(width: AppTheme.spacing2),
                            const Icon(
                              Icons.access_time,
                              color: AppTheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing3),
                    // Delete button (edit mode only)
                    if (_isEditing) ...[
                      const Divider(color: AppTheme.border),
                      const SizedBox(height: AppTheme.spacing2),
                      Center(
                        child: TextButton.icon(
                          onPressed: _handleDelete,
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Delete Ritual'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.error,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _handleTimePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final provider = context.read<RitualProvider>();

      if (_isEditing) {
        final updated = widget.ritual!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          time: _selectedTime,
        );
        await provider.updateRitual(updated);
      } else {
        await provider.createRitual(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          time: _selectedTime,
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save ritual: $e'),
            backgroundColor: AppTheme.error,
          ),
        );
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Ritual'),
        content: const Text(
          'Are you sure you want to delete this ritual? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await context.read<RitualProvider>().deleteRitual(widget.ritual!.id);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete ritual: $e'),
              backgroundColor: AppTheme.error,
            ),
          );
        }
      }
    }
  }
}
