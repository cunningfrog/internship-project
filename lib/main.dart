import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mini_taskhub/app/theme.dart';
import 'package:mini_taskhub/app/app_router.dart';
import 'package:mini_taskhub/auth/auth_service.dart';
import 'package:mini_taskhub/dashboard/task_service.dart';
import 'package:mini_taskhub/services/supabase_service.dart';
import 'package:mini_taskhub/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SupabaseService>(
          create: (_) => SupabaseService(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(
            supabaseService: context.read<SupabaseService>(),
          ),
        ),
        ChangeNotifierProvider<TaskService>(
          create: (context) => TaskService(
            supabaseService: context.read<SupabaseService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Mini TaskHub',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.initialRoute,
      ),
    );
  }
}
