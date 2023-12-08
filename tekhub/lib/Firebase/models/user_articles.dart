import 'package:tekhub/Firebase/models/articles.dart';

class UserArticle {
  UserArticle({
    required this.article,
    required this.quantity,
  });

  final Article article;
  int quantity;
}
