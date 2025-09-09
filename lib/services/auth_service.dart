import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _usersKey = 'registered_users';

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  bool _isLoggedIn = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  // Initialize the service
  Future<void> initialize() async {
    await _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

    if (_isLoggedIn) {
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final userMap = json.decode(userJson);
        _currentUser = User.fromMap(userMap);
      }
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, _isLoggedIn);

    if (_currentUser != null) {
      final userMap = _currentUser!.toMap();
      final userJson = json.encode(userMap);
      await prefs.setString(_userKey, userJson);
    }
  }

  // Register a new user
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Check if user already exists
      if (await _userExists(email)) {
        return false; // User already exists
      }

      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      // Save user to registered users list
      await _saveRegisteredUser(newUser, password);

      // Set as current user and log in
      _currentUser = newUser;
      _isLoggedIn = true;
      await _saveUserData();
      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // Login user
  Future<bool> login({required String email, required String password}) async {
    try {
      // Get registered users
      final registeredUsers = await _getRegisteredUsers();

      // Find user with matching email and password
      final userEntry = registeredUsers.entries.firstWhere(
        (entry) => entry.key == email,
        orElse: () => const MapEntry('', null),
      );

      if (userEntry.value == null) {
        return false; // User not found
      }

      // Verify password
      if (userEntry.value!['password'] != password) {
        return false; // Wrong password
      }

      // Create user object
      final userMap = userEntry.value!;
      final user = User(
        id: userMap['id'],
        name: userMap['name'],
        email: userMap['email'],
        profileImage: userMap['profileImage'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(userMap['createdAt']),
        lastLoginAt: DateTime.now(),
        gender: userMap['gender'],
        dateOfBirth: userMap['dateOfBirth'] != null
            ? DateTime.fromMillisecondsSinceEpoch(userMap['dateOfBirth'])
            : null,
        weight: userMap['weight']?.toDouble(),
        height: userMap['height']?.toDouble(),
      );

      // Update last login time
      await _updateLastLogin(email);

      // Set as current user and log in
      _currentUser = user;
      _isLoggedIn = true;
      await _saveUserData();

      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Logout user
  Future<void> logout() async {
    _currentUser = null;
    _isLoggedIn = false;
    await _saveUserData();
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
    if (_currentUser == null) {
      return false;
    }

    try {
      _currentUser = _currentUser!.copyWith(
        name: name,
        profileImage: profileImage,
        gender: gender,
        dateOfBirth: dateOfBirth,
        weight: weight,
        height: height,
      );

      await _saveUserData();
      await _updateRegisteredUser(_currentUser!);
      return true;
    } catch (e) {
      print('Profile update error: $e');
      return false;
    }
  }

  // Check if user exists
  Future<bool> _userExists(String email) async {
    final registeredUsers = await _getRegisteredUsers();
    return registeredUsers.containsKey(email);
  }

  // Save registered user
  Future<void> _saveRegisteredUser(User user, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final registeredUsers = await _getRegisteredUsers();

    registeredUsers[user.email] = {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'password': password,
      'profileImage': user.profileImage,
      'createdAt': user.createdAt.millisecondsSinceEpoch,
      'lastLoginAt': user.lastLoginAt?.millisecondsSinceEpoch,
      'gender': user.gender,
      'dateOfBirth': user.dateOfBirth?.millisecondsSinceEpoch,
      'weight': user.weight,
      'height': user.height,
    };

    final usersJson = json.encode(registeredUsers);
    await prefs.setString(_usersKey, usersJson);
  }

  // Get registered users
  Future<Map<String, dynamic>> _getRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);

    if (usersJson == null) return {};

    try {
      final Map<String, dynamic> users = json.decode(usersJson);
      return users;
    } catch (e) {
      return {};
    }
  }

  // Update registered user
  Future<void> _updateRegisteredUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final registeredUsers = await _getRegisteredUsers();

    if (registeredUsers.containsKey(user.email)) {
      registeredUsers[user.email]!['name'] = user.name;
      registeredUsers[user.email]!['profileImage'] = user.profileImage;
      registeredUsers[user.email]!['lastLoginAt'] =
          user.lastLoginAt?.millisecondsSinceEpoch;
      registeredUsers[user.email]!['gender'] = user.gender;
      registeredUsers[user.email]!['dateOfBirth'] =
          user.dateOfBirth?.millisecondsSinceEpoch;
      registeredUsers[user.email]!['weight'] = user.weight;
      registeredUsers[user.email]!['height'] = user.height;

      final usersJson = json.encode(registeredUsers);
      await prefs.setString(_usersKey, usersJson);
    }
  }

  // Update last login time
  Future<void> _updateLastLogin(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final registeredUsers = await _getRegisteredUsers();

    if (registeredUsers.containsKey(email)) {
      registeredUsers[email]!['lastLoginAt'] =
          DateTime.now().millisecondsSinceEpoch;

      final usersJson = json.encode(registeredUsers);
      await prefs.setString(_usersKey, usersJson);
    }
  }

  // Clear all data (for testing or reset)
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_usersKey);

    _currentUser = null;
    _isLoggedIn = false;
  }
}
