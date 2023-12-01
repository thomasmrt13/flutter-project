// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekhub/firebase/actions/result.dart';
import 'package:tekhub/firebase/models/articles.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result> addToCart(String userId, Article article) async {
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
          (Map<String, dynamic> item) => item['id'] == article.id,
        );

        if (existingItemIndex != -1) {
          // Article already in the cart, update quantity or perform other logic
          // For now, let's just update the quantity by incrementing it
          cartData[existingItemIndex]['quantity'] =
              (cartData[existingItemIndex]['quantity'] ?? 1) + 1;
        } else {
          // Add the article to the cart with quantity 1
          cartData.add({
            'id': article.id,
            'name': article.name,
            'price': article.price,
            'description': article.description,
            'type': _mapArticleTypeToString(article.type),
            'imageUrl': article.imageUrl,
            'quantity': 1,
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
        return 'computer';
      case ArticleType.tablet:
        return 'tablet';
    }
  }
}
