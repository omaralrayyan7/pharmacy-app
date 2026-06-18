import 'package:flutter/material.dart';
import 'auth_service.dart';

/// Provider used by [SignUpPage].
/// Exposes [isLoading] so the UI can show a spinner during async calls.
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // ── Sign Up ──────────────────────────────────────────────────────────────
  Future<String?> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final message = await _authService.signUp(email, password);

    _isLoading = false;
    notifyListeners();

    return message;
  }

  // ── Sign In ──────────────────────────────────────────────────────────────
  Future<String?> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final message = await _authService.signIn(email, password);

    _isLoading = false;
    notifyListeners();

    return message;
  }
}
