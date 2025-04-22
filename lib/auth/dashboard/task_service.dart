import 'package:flutter/foundation.dart';
import 'package:mini_taskhub/dashboard/task_model.dart';
import 'package:mini_taskhub/services/supabase_service.dart';

class TaskService extends ChangeNotifier {
  final SupabaseService _supabaseService;
  
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  TaskService({required SupabaseService supabaseService}) 
      : _supabaseService = supabaseService;
  
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  Future<void> loadTasks() async {
    _setLoading(true);
    _clearError();
    
    try {
      _tasks = await _supabaseService.getTasks();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load tasks. Please try again.');
    } finally {
      _setLoading(false);
    }
  }
  
  Future<bool> addTask(String title) async {
    _setLoading(true);
    _clearError();
    
    try {
      final newTask = Task(title: title);
      final createdTask = await _supabaseService.createTask(newTask);
      
      _tasks.insert(0, createdTask);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to add task. Please try again.');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  Future<bool> deleteTask(String taskId) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _supabaseService.deleteTask(taskId);
      
      _tasks.removeWhere((task) => task.id == taskId);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to delete task. Please try again.');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  Future<bool> toggleTaskStatus(String taskId, bool isCompleted) async {
    _setLoading(true);
    _clearError();
    
    try {
      final updatedTask = await _supabaseService.updateTaskStatus(taskId, isCompleted);
      
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        _tasks[taskIndex] = updatedTask;
        notifyListeners();
      }
      
      return true;
    } catch (e) {
      _setError('Failed to update task status. Please try again.');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
  
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
