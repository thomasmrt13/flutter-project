import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserResult {
  UserResult(this.user, this.error);
  final User? user;
  final String? error;
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isPasswordValid(String password) {
    // Use a regular expression to enforce password requirements
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  String _handleRegistrationError(dynamic error) {
    String errorMessage = 'An error occurred during registration.';

    // Check specific registration error cases
    if (error is FirebaseAuthException) {
      if (error.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      }
    }

    return errorMessage;
  }

  // Register with email and password
  Future<UserResult> registerWithEmailAndPassword(
      String email, String password, String username,) async {
    if (!_isPasswordValid(password)) {
      return UserResult(null, 'The password is too weak. It must contain at least 8 characters, '
          'including 1 uppercase letter, 1 number, and 1 special character.');
    }

    try {
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user information in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set(<String, String>{
        'email': email,
        'username': username,
      });

      final User? user = authResult.user;
      // Retrieve additional user information if needed
      // For example, you might fetch user data from Firestore

      return UserResult(user, null); // Return a UserResult instance with user information
    } catch (e) {
      return UserResult(null, _handleRegistrationError(e));
    }
  }

    String _handleLoginError(FirebaseAuthException error) {
    String errorMessage = 'An error occurred during login.';

    switch (error.code) {
      case 'user-not-found':
        errorMessage = 'No user found with this email address.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password.';
        break;
      case 'user-disabled':
        errorMessage = 'This user account has been disabled.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address format.';
        break;
      default:
        errorMessage = 'An unexpected error occurred during login.';
    }

    return errorMessage;
  }

  // Sign in with email and password
  Future<UserResult> signInWithEmailAndPassword(
      String email, String password,) async {
    try {
       final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
       final User? user = authResult.user;
      // Retrieve additional user information if needed
      // For example, you might fetch user data from Firestore

      return UserResult(user, null); // Return a UserResult instance with user information
    } on FirebaseAuthException catch (e) {
      return UserResult(null, _handleLoginError(e));
    } catch (e) {
      return UserResult(null, 'An unexpected error occurred during login.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
