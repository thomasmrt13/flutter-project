import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';

class ProviderListener extends ChangeNotifier {
  late String searchtext = '';
  late String activeType = 'all';
  late List<Article> articles = <Article>[];

  void updateArticles(List<Article> listArticles) {
    articles = listArticles;
    notifyListeners(); // Notifies the listeners that the data has changed
  }

  void updateSearchText(String typedSearchText) {
    searchtext = typedSearchText;
    notifyListeners(); // Notifies the listeners that the data has changed
  }

  void updateActiveType(String newType) {
    activeType = newType;
    notifyListeners(); // Notifies the listeners that the data has changed
  }
}
