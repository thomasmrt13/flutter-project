// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/user_articles.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      String userId, List<UserArticle> userArticles,) async {
    try {
      // Retrieve the user's current purchase history
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Convert the user's purchase history data to a List<Map<String, dynamic>>
        final List<Map<String, dynamic>> purchaseHistoryData =
            List<Map<String, dynamic>>.from(
                userSnapshot.data()!['purchaseHistory'],);

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
}
