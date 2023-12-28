import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/user_articles.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required this.userArticle,
    super.key,
  });
  final UserArticle userArticle;

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(userArticle.article.imageUrl),
              width: 80,
              height: 105,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  userArticle.article.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16,),
                ),
                const SizedBox(height: 10),
                Text(
                  '\u0024${userArticle.article.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color.fromARGB(255, 126, 217, 87),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('Quantity: '),
                    Text(
                      userArticle.quantity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final dynamic newArticle =
                            user.findUserArticleInCart(userArticle.article.id);
                        final Result<dynamic> result =
                            await userService.removeToCart(
                          user.uid,
                          newArticle == -1
                              ? UserArticle(
                                  article: userArticle.article,
                                  quantity: 1,
                                )
                              : userArticle,
                        );
                        if (result.success) {
                          if (!context.mounted) return;
                          final List<Map<String, dynamic>> cartData =
                              result.message as List<Map<String, dynamic>>;

                          // Convert cartData to a List<UserArticle>
                          final List<UserArticle> updatedCart =
                              cartData.map((Map<String, dynamic> map) {
                            return UserArticle(
                              article: Article(
                                id: map['id'],
                                name: map['name'],
                                price: map['price'],
                                description: map['description'],
                                type: mapStringToArticleType(map['type']),
                                imageUrl: map['imageUrl'],
                              ),
                              quantity: map['quantity'],
                            );
                          }).toList();
                          final MyUser newUserInfo = MyUser(
                            uid: user.uid,
                            email: user.email,
                            username: user.username,
                            phoneNumber: user.phoneNumber,
                            address: user.address,
                            cart: updatedCart,
                            purchaseHistory: user.purchaseHistory,
                            role: user.role,
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
                            '/Cart',
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
                      child: const Text(
                        '-',
                        style: TextStyle(color: Colors.red, fontSize: 40),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final dynamic newArticle =
                            user.findUserArticleInCart(userArticle.article.id);
                        final Result<dynamic> result =
                            await userService.addToCart(
                          user.uid,
                          newArticle == -1
                              ? UserArticle(
                                  article: userArticle.article,
                                  quantity: 1,
                                )
                              : userArticle,
                        );
                        if (result.success) {
                          if (!context.mounted) return;
                          final List<Map<String, dynamic>> cartData =
                              result.message as List<Map<String, dynamic>>;

                          // Convert cartData to a List<UserArticle>
                          final List<UserArticle> updatedCart =
                              cartData.map((Map<String, dynamic> map) {
                            return UserArticle(
                              article: Article(
                                id: map['id'],
                                name: map['name'],
                                price: map['price'],
                                description: map['description'],
                                type: mapStringToArticleType(map['type']),
                                imageUrl: map['imageUrl'],
                              ),
                              quantity: map['quantity'],
                            );
                          }).toList();
                          final MyUser newUserInfo = MyUser(
                            uid: user.uid,
                            email: user.email,
                            username: user.username,
                            phoneNumber: user.phoneNumber,
                            address: user.address,
                            cart: updatedCart,
                            purchaseHistory: user.purchaseHistory,
                            role: user.role,
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
                            '/Cart',
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
                      child: const Text(
                        '+',
                        style: TextStyle(color: Colors.green, fontSize: 40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
