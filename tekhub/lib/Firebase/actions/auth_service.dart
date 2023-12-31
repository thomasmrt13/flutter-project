import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/user_articles.dart';
import 'package:tekhub/Firebase/models/user_history_articles.dart';
import 'package:tekhub/Firebase/models/users.dart';

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
  Future<Result<dynamic>> registerWithEmailAndPassword(
    String email,
    String password,
    String confirmPassword,
    String username,
  ) async {
    if (!_isEmailValid(email)) {
      return Result<dynamic>.failure('Invalid email format.');
    }

    if (!_isPasswordValid(password)) {
      return Result<dynamic>.failure(
          'The password is too weak. It must contain at least 8 characters, '
          'including 1 uppercase letter, 1 number, and 1 special character.');
    }

    if (password != confirmPassword) {
      return Result<dynamic>.failure('The passwords do not match.');
    }

    try {
      final QuerySnapshot<Map<String, dynamic>> usernameCheck =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: username)
              .get();

      if (usernameCheck.docs.isNotEmpty) {
        // Username is already in use
        return Result<dynamic>.failure('The username is already in use.');
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
          .set(<String, dynamic>{
        'email': email,
        'username': username,
        'phoneNumber': '',
        'address': '',
        'cart': <dynamic>[],
        'purchaseHistory': <dynamic>[],
        'role': 'user',
        'profilePictureUrl': 'assets/images/pic0.png',
        'cardNumber': '',
        'creditCardName': '',
        'expirationDate': '',
        'cvv': '',
      });

      final User? user = authResult.user;
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .get();

      final List<UserArticle> cart = userDoc['cart'] != null
          ? await _fetchUserArticles(userDoc['cart'])
          : <UserArticle>[];
      final List<UserHistoryArticles> purchaseHistory =
          userDoc['purchaseHistory'] != null
              ? await _fetchUserHistoryArticles(userDoc['purchaseHistory'])
              : <UserHistoryArticles>[];

      final MyUser fetchedUser = MyUser(
        uid: user!.uid,
        email: user.email!,
        username: userDoc['username'] ?? '',
        phoneNumber: userDoc['phoneNumber'] ?? '',
        address: userDoc['address'] ?? '',
        cart: cart,
        purchaseHistory: purchaseHistory,
        role: userDoc['role'] ?? '',
        profilePictureUrl: userDoc['profilePictureUrl'] ?? '',
        cardNumber: userDoc['cardNumber'] ?? '',
        creditCardName: userDoc['creditCardName'] ?? '',
        expirationDate: userDoc['expirationDate'] ?? '',
        cvv: userDoc['cvv'] ?? '',
      );

      return Result<dynamic>.success(
        fetchedUser,
      );
    } catch (e) {
      return Result<dynamic>.failure(_handleRegistrationError(e));
    }
  }

  String _handleLoginError(FirebaseAuthException error) {
    String errorMessage = 'An error occurred during login.';

    switch (error.code) {
      case 'invalid-credential':
        errorMessage = 'Invalid credentials.';
        break;
      case 'invalid-login-credentials':
        errorMessage = 'Invalid credentials.';
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
  Future<Result<dynamic>> signInWithEmailAndPassword(
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
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .get();

      final List<UserArticle> cart = userDoc['cart'] != null
          ? await _fetchUserArticles(userDoc['cart'])
          : <UserArticle>[];
      final List<UserHistoryArticles> purchaseHistory =
          userDoc['purchaseHistory'] != null
              ? await _fetchUserHistoryArticles(userDoc['purchaseHistory'])
              : <UserHistoryArticles>[];

      final MyUser fetchedUser = MyUser(
        uid: user!.uid,
        email: user.email!,
        username: userDoc['username'] ?? '',
        phoneNumber: userDoc['phoneNumber'] ?? '',
        address: userDoc['address'] ?? '',
        cart: cart,
        purchaseHistory: purchaseHistory,
        role: userDoc['role'] ?? '',
        profilePictureUrl: userDoc['profilePictureUrl'] ?? '',
        cardNumber: userDoc['cardNumber'] ?? '',
        creditCardName: userDoc['creditCardName'] ?? '',
        expirationDate: userDoc['expirationDate'] ?? '',
        cvv: userDoc['cvv'] ?? '',
      );

      return Result<dynamic>.success(
        fetchedUser,
      );
    } on FirebaseAuthException catch (e) {
      return Result<dynamic>.failure(_handleLoginError(e));
    } catch (e) {
      return Result<dynamic>.failure(
          'An unexpected error occurred during login. $e',);
    }
  }

  Future<List<UserArticle>> _fetchUserArticles(
    List<dynamic>? articleData,
  ) async {
    if (articleData == null || articleData.isEmpty) {
      return <UserArticle>[]; // Return an empty list if no articles are present
    }

    try {
      final List<UserArticle> userArticles = <UserArticle>[];

      for (final Map<String, dynamic> articleInfo
          in List<Map<String, dynamic>>.from(articleData)) {
        final Article article = Article(
          id: articleInfo['id'] ?? '',
          name: articleInfo['name'] ?? '',
          price: (articleInfo['price'] ?? 0.0).toDouble(),
          description: articleInfo['description'] ?? '',
          type: _convertStringToArticleType(articleInfo['type']),
          imageUrl: articleInfo['imageUrl'] ?? '',
        );

        final UserArticle userArticle = UserArticle(
          article: article,
          quantity: articleInfo['quantity'] ?? 0,
        );

        userArticles.add(userArticle);
      }

      return userArticles;
    } catch (e) {
      return <UserArticle>[]; // Return an empty list in case of an error
    }
  }

  Future<List<UserHistoryArticles>> _fetchUserHistoryArticles(
    List<dynamic>? articleData,
  ) async {
    if (articleData == null || articleData.isEmpty) {
      return <UserHistoryArticles>[]; // Return an empty list if no articles are present
    }

    try {
      final List<UserHistoryArticles> userHistoryArticles =
          <UserHistoryArticles>[];

      for (final Map<String, dynamic> articleInfo
          in List<Map<String, dynamic>>.from(articleData)) {
        final Article article = Article(
          id: articleInfo['id'] ?? '',
          name: articleInfo['name'] ?? '',
          price: (articleInfo['price'] ?? 0.0).toDouble(),
          description: articleInfo['description'] ?? '',
          type: _convertStringToArticleType(articleInfo['type']),
          imageUrl: articleInfo['imageUrl'] ?? '',
        );

        final UserHistoryArticles userHistoryArticle = UserHistoryArticles(
          article: article,
          quantity: articleInfo['quantity'] ?? 0,
          purchaseDate: (articleInfo['purchaseDate'] as Timestamp).toDate(),
        );

        userHistoryArticles.add(userHistoryArticle);
      }

      return userHistoryArticles;
    } catch (e) {
      return <UserHistoryArticles>[]; // Return an empty list in case of an error
    }
  }

  ArticleType _convertStringToArticleType(String? type) {
    switch (type) {
      case 'phone':
        return ArticleType.phone;
      case 'laptop':
        return ArticleType.laptop;
      case 'tablet':
        return ArticleType.tablet;
      default:
        return ArticleType.phone; // Default to phone type if unknown
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Result<dynamic>> sendPasswordResetEmail(String email) async {
    try {
      if (!_isEmailValid(email)) {
        return Result<dynamic>.failure('Invalid email format.');
      }

      await _auth.sendPasswordResetEmail(email: email);
      return Result<dynamic>.success(
          'Password reset email sent. Check your inbox.',);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle case where the email doesn't exist
        return Result<dynamic>.failure('Email address not found.');
      } else {
        // Handle other FirebaseAuthException cases
        return Result<dynamic>.failure(
          'An unexpected error occurred during reset password.',
        );
      }
    } catch (e) {
      // Handle non-FirebaseAuthException errors
      return Result<dynamic>.failure(
        'An unexpected error occurred during reset password.',
      );
    }
  }
}
