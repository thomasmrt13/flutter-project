import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/firebase/actions/article_service.dart';

class ProviderListener extends ChangeNotifier {
  late String searchtext = '';
  late String activeType = 'all';
  late List<Article> articles = <Article>[];
  List<Article> get _articles => articles;
  late MyUser user = MyUser as MyUser;
  final ArticleService articleService = ArticleService();

  void updateArticles(List<Article> listArticles) {
    articles = listArticles;
    notifyListeners(); // Notifies the listeners that the data has changed
  }

  Future<void> fetchArticles() async {
    // Add your logic to fetch articles
    // For example:
    final Result<dynamic> resultArticles =
       articleService.getAllArticles() as Result<dynamic>;
    if (resultArticles.success) {
      final List<Article> fetchedArticles = resultArticles.message;
      articles = fetchedArticles;
      notifyListeners();
    }
  }

  void updateSearchText(String typedSearchText) {
    searchtext = typedSearchText;
    notifyListeners(); // Notifies the listeners that the data has changed
  }

  void updateActiveType(String newType) {
    activeType = newType;
    notifyListeners(); // Notifies the listeners that the data has changed
  }

  void updateUser(MyUser newUser) {
    user = newUser;
    notifyListeners(); // Notifies the listeners that the data has changed
  }
}
