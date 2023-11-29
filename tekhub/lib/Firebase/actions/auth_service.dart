// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tekhub/firebase/actions/result.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isPasswordValid(String password) {
    // Use a regular expression to enforce password requirements
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }

  String _handleRegistrationError(dynamic error) {
    String errorMessage = 'An error occurred during registration.';

    // Check specific registration error cases
    if (error is FirebaseAuthException) {
      if (error.code == 'email-already-in-use') {
        errorMessage = 'The email address is already in use.';
      } else if (error.code == 'username-already-in-use') {
        errorMessage = 'The username is already in use.';
      }
    }

    return errorMessage;
  }

  // Register with email and password
  Future<Result> registerWithEmailAndPassword(
    String email,
    String password,
    String confirmPassword,
    String username,
  ) async {
    if (!_isEmailValid(email)) {
      return Result(false, 'Invalid email format.');
    }

    if (!_isPasswordValid(password)) {
      return Result(
          false,
          'The password is too weak. It must contain at least 8 characters, '
          'including 1 uppercase letter, 1 number, and 1 special character.');
    }

    if (password != confirmPassword) {
      return Result(false, 'The passwords do not match.');
    }

    try {
      final QuerySnapshot<Map<String, dynamic>> usernameCheck =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: username)
              .get();

      if (usernameCheck.docs.isNotEmpty) {
        // Username is already in use
        return Result(false, 'The username is already in use.');
      }

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

      return Result(
          true, user); // Return a UserResult instance with user information
    } catch (e) {
      return Result(false, _handleRegistrationError(e));
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
  Future<Result> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = authResult.user;
      // Retrieve additional user information if needed
      // For example, you might fetch user data from Firestore

      return Result(
          true, user); // Return a UserResult instance with user information
    } on FirebaseAuthException catch (e) {
      return Result(false, _handleLoginError(e));
    } catch (e) {
      return Result(false, 'An unexpected error occurred during login.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Result> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Result(true, 'Password reset email sent. Check your inbox.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle case where the email doesn't exist
        return Result(false, 'Email address not found.');
      } else {
        // Handle other FirebaseAuthException cases
        return Result(
            false, 'An unexpected error occurred during reset password.');
      }
    } catch (e) {
      // Handle non-FirebaseAuthException errors
      return Result(
          false, 'An unexpected error occurred during reset password.');
    }
  }
}
