class Constants {
  // Supabase configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 350);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Assets paths
  static const String logoPath = 'assets/images/logo.svg';
  static const String emptyStatePath = 'assets/images/empty_state.svg';
  static const String taskIconPath = 'assets/images/task_icon.svg';
  
  // Error messages
  static const String emailRequiredError = 'Email is required';
  static const String invalidEmailError = 'Please enter a valid email';
  static const String passwordRequiredError = 'Password is required';
  static const String passwordLengthError = 'Password must be at least 6 characters';
  static const String taskNameRequiredError = 'Task name is required';
  
  // Success messages
  static const String taskAddedSuccess = 'Task added successfully';
  static const String taskDeletedSuccess = 'Task deleted successfully';
  static const String taskCompletedSuccess = 'Task marked as completed';
  
  // App texts
  static const String appName = 'Mini TaskHub';
  static const String loginTitle = 'Welcome Back';
  static const String signupTitle = 'Create Account';
  static const String dashboardTitle = 'Your Tasks';
  static const String noTasksMessage = 'No tasks yet. Add a new task to get started!';
  static const String addTaskTitle = 'Add New Task';
}
