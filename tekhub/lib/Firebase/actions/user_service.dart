// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/user_articles.dart';
import 'package:tekhub/Firebase/models/user_history_articles.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> updateUserInformation(
    String userId,
    String username,
    String phoneNumber,
    String address,
    String firstName,
    String lastName,
    String profilePictureUrl,
  ) async {
    try {
      // Check if the username is already in use by another user
      final QuerySnapshot<Map<String, dynamic>> usernameCheck =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: username)
              .get();

      // Exclude the current user from the check
      final QuerySnapshot<Map<String, dynamic>> currentUserCheck =
          await FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: userId)
              .get();

      if (usernameCheck.docs.isNotEmpty &&
          usernameCheck.docs.first.id != currentUserCheck.docs.first.id) {
        // Username is already in use by another user
        return Result(false, 'The username is already in use.');
      }

      // Update user information in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'username': username,
        'phoneNumber': phoneNumber,
        'address': address,
        'firstName': firstName,
        'lastName': lastName,
        'profilePictureUrl': profilePictureUrl,
      });

      return Result(true, 'User information updated successfully.');
    } catch (e) {
      return Result(false, 'An unexpected error occurred.');
    }
  }

  Future<Result> deleteUser(String userId) async {
    try {
      // Delete the user's authentication credentials
      await _auth.currentUser?.delete();

      // Delete the user's information from Firestore
      await _firestore.collection('users').doc(userId).delete();

      return Result(true, 'User deleted successfully.');
    } catch (e) {
      return Result(false, 'An unexpected error occurred.');
    }
  }

  Future<Result> addToCart(String userId, UserArticle userArticle) async {
    try {
      // Retrieve the user's current cart
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's cart data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(userSnapshot.data()!['cart']);

        // Check if the article is already in the cart
        final int existingItemIndex = cartData.indexWhere(
          (Map<String, dynamic> item) => item['id'] == userArticle.article.id,
        );

        if (existingItemIndex != -1) {
          // Article already in the cart, update quantity or perform other logic
          // For now, let's just update the quantity by incrementing it
          cartData[existingItemIndex]['quantity'] =
              (cartData[existingItemIndex]['quantity'] ?? 1) +
                  userArticle.quantity;
        } else {
          // Add the article to the cart with quantity
          cartData.add({
            'id': userArticle.article.id,
            'name': userArticle.article.name,
            'price': userArticle.article.price,
            'description': userArticle.article.description,
            'type': _mapArticleTypeToString(userArticle.article.type),
            'imageUrl': userArticle.article.imageUrl,
            'quantity': userArticle.quantity,
          });
        }

        // Update the user's cart in Firestore
        await _firestore.collection('users').doc(userId).update({
          'cart': cartData,
        });
        return Result(
          true,
          'Article added to cart.',
        );
      } else {
        return Result(
          false,
          'User not found.',
        );
      }
    } catch (e) {
      return Result(
        false,
        'An unexpected error occurred during reset password.',
      );
    }
  }

  // Utility function to map ArticleType enum to String
  String _mapArticleTypeToString(ArticleType type) {
    switch (type) {
      case ArticleType.phone:
        return 'phone';
      case ArticleType.laptop:
        return 'laptop';
      case ArticleType.tablet:
        return 'tablet';
    }
  }

  Future<Result> getCartProducts(String userId) async {
    try {
      // Retrieve the user's current cart
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's cart data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(userSnapshot.data()!['cart']);

        // Convert cartData to a List of UserArticle objects
        final List<UserArticle> cartProducts = cartData.map((item) {
          return UserArticle(
            article: Article(
              id: item['id'],
              name: item['name'],
              price: item['price'],
              description: item['description'],
              type: _mapStringToArticleType(item['type']),
              imageUrl: item['imageUrl'],
            ),
            quantity: item['quantity'],
          );
        }).toList();

        return Result(true, cartProducts);
      } else {
        return Result(true, []);
      }
    } catch (e) {
      return Result(false, 'Error getting cart products');
    }
  }

  // Utility function to map String to ArticleType enum
  ArticleType _mapStringToArticleType(String typeString) {
    switch (typeString) {
      case 'phone':
        return ArticleType.phone;
      case 'laptop':
        return ArticleType.laptop;
      case 'tablet':
        return ArticleType.tablet;
      default:
        return ArticleType.phone; // Default to phone if unknown type
    }
  }

  Future<Result> deleteProductFromCart(String userId, String productId) async {
    try {
      // Retrieve the user's current cart
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's cart data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(userSnapshot.data()!['cart']);

        // Find the index of the product with the specified productId
        final int indexToDelete = cartData.indexWhere(
          (item) => item['id'] == productId,
        );

        if (indexToDelete != -1) {
          // Remove the product from the cart
          cartData.removeAt(indexToDelete);

          // Update the user's cart in Firestore
          await _firestore.collection('users').doc(userId).update({
            'cart': cartData,
          });

          return Result(true, 'Product removed from cart successfully.');
        } else {
          return Result(false, 'Product not found in cart.');
        }
      } else {
        return Result(false, 'User not found.');
      }
    } catch (e) {
      return Result(false, 'An unexpected error occurred.');
    }
  }

  Future<Result> addToPurchaseHistory(
    String userId,
    List<UserArticle> userArticles,
  ) async {
    try {
      // Retrieve the user's current purchase history
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's purchase history data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> purchaseHistoryData =
            List<Map<String, dynamic>>.from(
          userSnapshot.data()!['purchaseHistory'],
        );

        // Add the userArticles to the purchase history
        for (final UserArticle userArticle in userArticles) {
          purchaseHistoryData.add({
            'id': userArticle.article.id,
            'name': userArticle.article.name,
            'price': userArticle.article.price,
            'description': userArticle.article.description,
            'type': _mapArticleTypeToString(userArticle.article.type),
            'imageUrl': userArticle.article.imageUrl,
            'quantity': userArticle.quantity,
            'purchaseDate': DateTime.now(),
          });
        }

        // Update the user's purchase history in Firestore
        await _firestore.collection('users').doc(userId).update({
          'purchaseHistory': purchaseHistoryData,
        });

        return Result(true, 'Articles added to purchase history.');
      } else {
        return Result(
          false,
          'User not found.',
        );
      }
    } catch (e) {
      return Result(
        false,
        'An unexpected error occurred.',
      );
    }
  }

  Future<Result> getHistoryProducts(String userId) async {
    try {
      // Retrieve the user's current cart
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's cart data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> historyData =
            List<Map<String, dynamic>>.from(
          userSnapshot.data()!['purchaseHistory'],
        );

        // Convert historyData to a List of UserArticle objects
        final List<UserHistoryArticles> historyProducts =
            historyData.map((item) {
          return UserHistoryArticles(
            article: Article(
              id: item['id'],
              name: item['name'],
              price: item['price'],
              description: item['description'],
              type: _mapStringToArticleType(item['type']),
              imageUrl: item['imageUrl'],
            ),
            quantity: item['quantity'],
            purchaseDate: item['purchaseDate'],
          );
        }).toList();

        return Result(true, historyProducts);
      } else {
        return Result(true, []);
      }
    } catch (e) {
      return Result(false, 'Error getting history products');
    }
  }

  Future<Result> getOneProductFromHistory(
    String userId,
    String articleId,
  ) async {
    try {
      // Retrieve the user's current purchase history
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's purchase history data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> purchaseHistoryData =
            List<Map<String, dynamic>>.from(
          userSnapshot.data()!['purchaseHistory'] ?? [],
        );

        // Find the entry with the specified articleId
        final Map<String, dynamic> productEntry =
            purchaseHistoryData.firstWhere(
          (entry) => entry['article']['id'] == articleId,
        );

        final Article article = Article(
          id: productEntry['article']['id'],
          name: productEntry['article']['name'],
          price: productEntry['article']['price'],
          description: productEntry['article']['description'],
          type: _mapStringToArticleType(productEntry['article']['type']),
          imageUrl: productEntry['article']['imageUrl'],
        );

        final UserHistoryArticles userHistoryArticle = UserHistoryArticles(
          article: article,
          quantity: productEntry['quantity'],
          purchaseDate: productEntry['purchaseDate'].toDate(),
        );

        return Result(true, userHistoryArticle);
      } else {
        return Result(false, 'User not found.');
      }
    } catch (e) {
      return Result(false, 'An unexpected error occurred.');
    }
  }

  Future<Result> deleteProductFromHistory(
      String userId, String articleId) async {
    try {
      // Retrieve the user's current purchase history
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's purchase history data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> purchaseHistoryData =
            List<Map<String, dynamic>>.from(
                userSnapshot.data()!['purchaseHistory'] ?? []);

        // Find the index of the product with the specified articleId
        final int indexToDelete = purchaseHistoryData.indexWhere(
          (entry) => entry['article']['id'] == articleId,
        );

        if (indexToDelete != -1) {
          // Remove the product from the purchase history
          purchaseHistoryData.removeAt(indexToDelete);

          // Update the user's purchase history in Firestore
          await _firestore.collection('users').doc(userId).update({
            'purchaseHistory': purchaseHistoryData,
          });

          return Result(
              true, 'Product removed from purchase history successfully.');
        } else {
          return Result(false, 'Product not found in purchase history.');
        }
      } else {
        return Result(false, 'User not found.');
      }
    } catch (e) {
      return Result(false, 'An unexpected error occurred.');
    }
  }
}
