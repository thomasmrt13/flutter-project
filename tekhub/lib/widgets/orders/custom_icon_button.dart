import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/user_history_articles.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.id,
    super.key,
    this.icon,
  });
  final IconData? icon;
  final String id;

  @override
  Widget build(BuildContext context) {
    ArticleType mapStringToArticleType(String typeString) {
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

    final MyUser user = Provider.of<ProviderListener>(context).user;
    final UserService userService = UserService();
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color.fromARGB(255, 39, 39, 39),
      ),
      // Wrap the IconButton in a Material widget for the
      // IconButton's splash to render above the container.
      child: Material(
        borderRadius: BorderRadius.circular(24),
        type: MaterialType.transparency,
        // Hard Edge makes sure the splash is clipped at the border of this
        // Material widget, which is circular due to the radius above.
        clipBehavior: Clip.hardEdge,
        child: IconButton(
          color: const Color.fromARGB(255, 126, 217, 87),
          iconSize: 18,
          icon: Icon(
            icon ?? Icons.calendar_today,
          ),
          onPressed: () async {
            final Result<dynamic> result =
                await userService.deleteProductFromHistory(
              user.uid,
              id,
            );
            if (result.success) {
              if (!context.mounted) return;
              final List<Map<String, dynamic>> cartData =
                  result.message as List<Map<String, dynamic>>;

              // Convert cartData to a List<UserArticle>
              final List<UserHistoryArticles> updatedUserHistory =
                  cartData.map((Map<String, dynamic> map) {
                return UserHistoryArticles(
                  article: Article(
                    id: map['id'],
                    name: map['name'],
                    price: map['price'],
                    description: map['description'],
                    type: mapStringToArticleType(map['type']),
                    imageUrl: map['imageUrl'],
                  ),
                  quantity: map['quantity'],
                  purchaseDate: map['purchaseDate'].toDate(),
                );
              }).toList();
              final MyUser newUserInfo = MyUser(
                uid: user.uid,
                email: user.email,
                username: user.username,
                phoneNumber: user.phoneNumber,
                address: user.address,
                cart: user.cart,
                purchaseHistory: updatedUserHistory,
                role: user.role,
                profilePictureUrl: user.profilePictureUrl,
                cardNumber: user.cardNumber,
                creditCardName: user.creditCardName,
                expirationDate: user.expirationDate,
                cvv: user.cvv,
              );
              Provider.of<ProviderListener>(
                context,
                listen: false,
              ).updateUser(newUserInfo);
              // await onValidationButtonPressed();
              if (!context.mounted) return;
              await Navigator.pushNamed(
                context,
                '/Orders',
              );
            } else {
              if (!context.mounted) return;
              // Registration failed, show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result.message.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
