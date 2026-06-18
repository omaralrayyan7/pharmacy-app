import 'package:flutter/material.dart';

/// Simple ChangeNotifier that tracks whether the user is authenticated.
/// Injected at the root by [main.dart] via [ChangeNotifierProvider].
class AuthNotifier with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  /// Call with [true] after login, [false] after logout.
  void authenticate(bool status) {
    _isAuthenticated = status;
    notifyListeners();
  }
}
