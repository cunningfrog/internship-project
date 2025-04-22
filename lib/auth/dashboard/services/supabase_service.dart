import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mini_taskhub/dashboard/task_model.dart';

class SupabaseService {
  // Get the Supabase client instance
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  
  // Get current user id
  String? get currentUserId => _supabaseClient.auth.currentUser?.id;
  
  // Check if user is logged in
  bool get isAuthenticated => _supabaseClient.auth.currentUser != null;

  // Authentication methods
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // Task methods
  Future<List<Task>> getTasks() async {
    final userId = currentUserId;
    if (userId == null) {
      return [];
    }

    final response = await _supabaseClient
        .from('tasks')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((task) => Task.fromJson(task)).toList();
  }

  Future<Task> createTask(Task task) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final taskWithUserId = task.copyWith(userId: userId);
    final response = await _supabaseClient
        .from('tasks')
        .insert(taskWithUserId.toJson())
        .select()
        .single();

    return Task.fromJson(response);
  }

  Future<void> deleteTask(String taskId) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await _supabaseClient
        .from('tasks')
        .delete()
        .eq('id', taskId)
        .eq('user_id', userId);
  }

  Future<Task> updateTaskStatus(String taskId, bool isCompleted) async {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await _supabaseClient
        .from('tasks')
        .update({'is_completed': isCompleted})
        .eq('id', taskId)
        .eq('user_id', userId)
        .select()
        .single();

    return Task.fromJson(response);
  }
}
