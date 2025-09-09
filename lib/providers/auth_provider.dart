import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  // Initialize the provider
  Future<void> initialize() async {
    _setLoading(true);
    try {
      await _authService.initialize();
      _user = _authService.currentUser;
      _error = null;
    } catch (e) {
      _error = 'Failed to initialize authentication: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Register a new user
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      final success = await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      if (success) {
        _user = _authService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Registration failed. User may already exist.';
        return false;
      }
    } catch (e) {
      _error = 'Registration error: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Login user
  Future<bool> login({
    required String email,
    required String password,
    bool remember = false,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      final success = await _authService.login(
        email: email,
        password: password,
        remember: remember,
      );

      if (success) {
        _user = _authService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Login failed. Please check your credentials.';
        return false;
      }
    } catch (e) {
      _error = 'Login error: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout user
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.logout();
      _user = null;
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = 'Logout error: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? name,
    String? profileImage,
    String? gender,
    DateTime? dateOfBirth,
    double? weight,
    double? height,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      final success = await _authService.updateProfile(
        name: name,
        profileImage: profileImage,
        gender: gender,
        dateOfBirth: dateOfBirth,
        weight: weight,
        height: height,
      );

      if (success) {
        _user = _authService.currentUser;
        notifyListeners();
        return true;
      } else {
        _error = 'Profile update failed.';
        return false;
      }
    } catch (e) {
      _error = 'Profile update error: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Get user's first name
  String get firstName {
    if (_user == null) return '';
    final nameParts = _user!.name.split(' ');
    return nameParts.isNotEmpty ? nameParts[0] : _user!.name;
  }

  // Get user's display name (first name or full name)
  String get displayName {
    if (_user == null) return '';
    return _user!.name;
  }

  // Check if user has profile image
  bool get hasProfileImage {
    return _user?.profileImage != null && _user!.profileImage!.isNotEmpty;
  }
}
