import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mini_taskhub/app/theme.dart';
import 'package:mini_taskhub/dashboard/task_model.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool) onStatusChanged;
  final VoidCallback onDelete;
  final Animation<double> animation;

  const TaskTile({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onDelete,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Slidable(
            key: ValueKey(task.id),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: onDelete),
              children: [
                SlidableAction(
                  onPressed: (_) => onDelete(),
                  backgroundColor: AppTheme.errorColor,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
                ),
              ],
            ),
            child: _buildTaskCard(),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            _buildCheckbox(),
            const SizedBox(width: 16),
            Expanded(child: _buildTaskDetails()),
            _buildDateLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: task.isCompleted 
            ? null 
            : Border.all(color: AppTheme.primaryColor, width: 2),
        color: task.isCompleted ? AppTheme.primaryColor : Colors.transparent,
      ),
      child: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onStatusChanged(value ?? false),
          activeColor: AppTheme.primaryColor,
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          shape: const CircleBorder(),
        ),
      ),
    );
  }

  Widget _buildTaskDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: AppTheme.bodyStyle.copyWith(
            decoration: task.isCompleted 
                ? TextDecoration.lineThrough 
                : TextDecoration.none,
            color: task.isCompleted 
                ? AppTheme.secondaryTextColor 
                : AppTheme.textColor,
            fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDateLabel() {
    final dateStr = DateFormat('MMM d').format(task.createdAt);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        dateStr,
        style: AppTheme.captionStyle.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}
