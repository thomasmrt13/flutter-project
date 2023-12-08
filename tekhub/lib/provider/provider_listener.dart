import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/users.dart';

class ProviderListener extends ChangeNotifier {
  late String searchtext = '';
  late String activeType = 'all';
  late List<Article> articles = <Article>[];
  late MyUser user = MyUser as MyUser;

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

    void updateUser(MyUser newUser) {
    user = newUser;
    notifyListeners(); // Notifies the listeners that the data has changed
  }
}
