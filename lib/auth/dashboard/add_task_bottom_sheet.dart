import 'package:flutter/material.dart';
import 'package:mini_taskhub/app/theme.dart';
import 'package:mini_taskhub/utils/validators.dart';
import 'package:mini_taskhub/widgets/custom_button.dart';
import 'package:mini_taskhub/widgets/custom_text_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Function(String) onAddTask;
  final bool isLoading;

  const AddTaskBottomSheet({
    super.key,
    required this.onAddTask,
    this.isLoading = false,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onAddTask(_taskController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Task',
                  style: AppTheme.subheadingStyle,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Task Name',
              controller: _taskController,
              validator: Validators.validateTaskName,
              textInputAction: TextInputAction.done,
              onEditingComplete: _addTask,
              maxLines: 3,
              maxLength: 100,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Add Task',
              onPressed: _addTask,
              isLoading: widget.isLoading,
              icon: const Icon(Icons.add, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
