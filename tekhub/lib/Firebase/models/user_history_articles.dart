import 'package:tekhub/Firebase/models/articles.dart';

class UserHistoryArticles {
  UserHistoryArticles({
    required this.article,
    required this.quantity,
    required this.purchaseDate,
  });

  final Article article;
  final int quantity;
  final DateTime purchaseDate;
}
