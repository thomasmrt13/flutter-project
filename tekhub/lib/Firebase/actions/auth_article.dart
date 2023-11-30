import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekhub/firebase/actions/result.dart';
import 'package:tekhub/firebase/models/articles.dart';

class ArticleService {
  Future<Result> getAllArticles() async {
    try {
      QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance.collection('articles').get();

      List<Article> articles = articlesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Article(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          description: data['description'] ?? '',
          type: _parseArticleType(data['type']),
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();

      return Result(true, articles); // Return successful result with articles
    } catch (e) {
      print('Error getting articles: $e');
      return Result(false,
          'Error getting articles'); // Return failure result with error message
    }
  }

  ArticleType _parseArticleType(String type) {
    switch (type) {
      case 'phone':
        return ArticleType.phone;
      case 'computer':
        return ArticleType.computer;
      case 'tablet':
        return ArticleType.tablet;
      default:
        return ArticleType.phone; // Default to phone if type is not recognized
    }
  }

  String _mapArticleTypeToString(ArticleType type) {
    switch (type) {
      case ArticleType.phone:
        return 'phone';
      case ArticleType.computer:
        return 'computer';
      case ArticleType.tablet:
        return 'tablet';
    }
  }

  Future<Result> getArticleById(String articleId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> articleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .doc(articleId)
              .get();

      if (!articleSnapshot.exists) {
        return Result(false,
            'Article not found'); // Return failure result with error message
      }

      Map<String, dynamic> data =
          articleSnapshot.data() as Map<String, dynamic>;
      Article article = Article(
        id: articleSnapshot.id,
        name: data['name'] ?? '',
        price: (data['price'] ?? 0.0).toDouble(),
        description: data['description'] ?? '',
        type: _parseArticleType(data['type']),
        imageUrl: data['imageUrl'] ?? '',
      );

      return Result(true, article); // Return successful result with the article
    } catch (e) {
      print('Error getting article: $e');
      return Result(false,
          'Error getting article'); // Return failure result with error message
    }
  }

  Future<Result> searchArticles(String query) async {
    try {
      // Convert the query to lowercase for case-insensitive comparison
      String lowercaseQuery = query.toLowerCase();

      // Create an array of substrings from the query
      List<String> querySubstrings = [];
      for (int i = 1; i <= lowercaseQuery.length; i++) {
        querySubstrings.add(lowercaseQuery.substring(0, i));
      }

      // Use array-contains-any to match any substring
      QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('searchKeywords', arrayContainsAny: querySubstrings)
              .get();

      List<Article> articles = articlesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Article(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          description: data['description'] ?? '',
          type: _parseArticleType(data['type']),
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();

      return Result(true,
          articles); // Return successful result with the matching articles
    } catch (e) {
      print('Error searching articles: $e');
      return Result(false,
          'Error searching articles'); // Return failure result with error message
    }
  }

  Future<Result> getArticlesByFilter(ArticleType filterType) async {
    try {
      QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('type', isEqualTo: _mapArticleTypeToString(filterType))
              .get();

      List<Article> articles = articlesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Article(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          description: data['description'] ?? '',
          type: _parseArticleType(data['type']),
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();

      return Result(true,
          articles); // Return successful result with the matching articles
    } catch (e) {
      print('Error getting articles by filter: $e');
      return Result(false,
          'Error getting articles by filter'); // Return failure result with error message
    }
  }
}
