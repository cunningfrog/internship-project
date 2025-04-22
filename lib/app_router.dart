import 'package:flutter/material.dart';
import 'package:mini_taskhub/auth/login_screen.dart';
import 'package:mini_taskhub/auth/signup_screen.dart';
import 'package:mini_taskhub/dashboard/dashboard_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String dashboardRoute = '/dashboard';

  static String get initialRoute {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      return dashboardRoute;
    }
    return loginRoute;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
