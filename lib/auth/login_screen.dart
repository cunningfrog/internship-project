import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_taskhub/app/app_router.dart';
import 'package:mini_taskhub/app/theme.dart';
import 'package:mini_taskhub/auth/auth_service.dart';
import 'package:mini_taskhub/utils/constants.dart';
import 'package:mini_taskhub/utils/validators.dart';
import 'package:mini_taskhub/widgets/custom_button.dart';
import 'package:mini_taskhub/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authService = context.read<AuthService>();
      final success = await authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.dashboardRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      Constants.logoPath,
                      height: 80,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      Constants.loginTitle,
                      style: AppTheme.headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue to your tasks',
                      style: AppTheme.captionStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    if (authService.errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          authService.errorMessage!,
                          style: AppTheme.captionStyle.copyWith(
                            color: AppTheme.errorColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocus,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      validator: Validators.validatePassword,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocus,
                      onEditingComplete: _login,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Log In',
                      onPressed: _login,
                      isLoading: authService.isLoading,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: AppTheme.captionStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRouter.signupRoute,
                            );
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
