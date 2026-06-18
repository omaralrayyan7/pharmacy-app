import 'package:firebase_auth/firebase_auth.dart';

/// Low-level Firebase Auth wrapper.
/// Called by [AuthProvider] – not used directly by UI.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ── Sign Up ──────────────────────────────────────────────────────────────
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Sign Up Successful!';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

  // ── Sign In ──────────────────────────────────────────────────────────────
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Sign In Successful!';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }

  // ── Sign Out ─────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
