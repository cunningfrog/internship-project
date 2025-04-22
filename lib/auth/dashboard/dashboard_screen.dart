import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_taskhub/app/app_router.dart';
import 'package:mini_taskhub/app/theme.dart';
import 'package:mini_taskhub/auth/auth_service.dart';
import 'package:mini_taskhub/dashboard/add_task_bottom_sheet.dart';
import 'package:mini_taskhub/dashboard/task_model.dart';
import 'package:mini_taskhub/dashboard/task_service.dart';
import 'package:mini_taskhub/dashboard/task_tile.dart';
import 'package:mini_taskhub/utils/constants.dart';
import 'package:mini_taskhub/widgets/loading_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Constants.mediumAnimationDuration,
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTasks();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    await context.read<TaskService>().loadTasks();
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddTaskBottomSheet(
          onAddTask: _addTask,
          isLoading: context.watch<TaskService>().isLoading,
        );
      },
    );
  }

  Future<void> _addTask(String title) async {
    final success = await context.read<TaskService>().addTask(title);
    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Constants.taskAddedSuccess),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  Future<void> _deleteTask(String taskId) async {
    final success = await context.read<TaskService>().deleteTask(taskId);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Constants.taskDeletedSuccess),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  Future<void> _toggleTaskStatus(String taskId, bool isCompleted) async {
    await context.read<TaskService>().toggleTaskStatus(taskId, isCompleted);
    if (isCompleted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(Constants.taskCompletedSuccess),
          backgroundColor: AppTheme.successColor,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _logout() async {
    await context.read<AuthService>().signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskService = context.watch<TaskService>();
    final tasks = taskService.tasks;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadTasks,
        color: AppTheme.primaryColor,
        child: taskService.isLoading && tasks.isEmpty
            ? const LoadingIndicator(message: 'Loading tasks...')
            : _buildTaskList(tasks),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskBottomSheet,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks) {
    if (tasks.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: tasks.length,
        padding: const EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskTile(
            key: ValueKey(task.id),
            task: task,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController..forward(),
                curve: Curves.easeInOut,
              ),
            ),
            onStatusChanged: (isCompleted) {
              if (task.id != null) {
                _toggleTaskStatus(task.id!, isCompleted);
              }
            },
            onDelete: () {
              if (task.id != null) {
                _deleteTask(task.id!);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Constants.emptyStatePath,
            height: 150,
          ),
          const SizedBox(height: 24),
          Text(
            Constants.noTasksMessage,
            style: AppTheme.bodyStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _showAddTaskBottomSheet,
            icon: const Icon(Icons.add),
            label: const Text('Add Your First Task'),
            style: AppTheme.primaryButtonStyle,
          ),
        ],
      ),
    );
  }
}
