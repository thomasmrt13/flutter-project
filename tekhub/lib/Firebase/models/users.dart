import 'package:tekhub/Firebase/models/user_articles.dart';
import 'package:tekhub/Firebase/models/user_history_articles.dart';

class MyUser {
  MyUser({
    required this.uid,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.address,
    required this.cart,
    required this.purchaseHistory,
    required this.role,
    this.profilePictureUrl,
    this.cardNumber,
    this.creditCardName,
    this.expirationDate,
    this.cvv,
  });
  dynamic findUserArticleInCart(String articleId) {
    try {
      return cart.firstWhere(
        (UserArticle userArticle) => userArticle.article.id == articleId,
      );
    } catch (e) {
      return -1;
    }
  }

  final String uid;
  final String email;
  final String username;
  final String phoneNumber;
  final String address;
  final List<UserArticle> cart;
  final List<UserHistoryArticles> purchaseHistory;
  final String role;
  final String? profilePictureUrl;
  final String? cardNumber;
  final String? creditCardName;
  final String? expirationDate;
  final String? cvv;
}

enum UserRole { admin, user }
