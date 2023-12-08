import 'package:tekhub/firebase/models/articles.dart';

class MyUser {
  MyUser({
    required this.uid,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.address,
    required this.firstName,
    required this.lastName,
    required this.cart,
    required this.purchaseHistory,
    required this.role,
    this.profilePictureUrl,
  });

  final String uid;
  final String email;
  final String username;
  final String phoneNumber;
  final String address;
  final String firstName;
  final String lastName;
  final List<Article> cart;
  final List<Article> purchaseHistory;
  final UserRole role;
  final String? profilePictureUrl;
}

enum UserRole { admin, user }
