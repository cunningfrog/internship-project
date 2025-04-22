import 'package:flutter/foundation.dart';
import 'package:mini_taskhub/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final SupabaseService _supabaseService;
  
  bool _isLoading = false;
  String? _errorMessage;
  
  AuthService({required SupabaseService supabaseService}) 
      : _supabaseService = supabaseService;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _supabaseService.isAuthenticated;
  
  Future<bool> signUp({required String email, required String password}) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _supabaseService.signUp(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        notifyListeners();
        return true;
      } else {
        _setError('Failed to create account. Please try again.');
        return false;
      }
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred. Please try again.');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  Future<bool> signIn({required String email, required String password}) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _supabaseService.signIn(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        notifyListeners();
        return true;
      } else {
        _setError('Invalid email or password. Please try again.');
        return false;
      }
    } on AuthException catch (e) {
      _setError(e.message);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred. Please try again.');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> signOut() async {
    _setLoading(true);
    _clearError();
    
    try {
      await _supabaseService.signOut();
      notifyListeners();
    } catch (e) {
      _setError('Failed to sign out. Please try again.');
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
