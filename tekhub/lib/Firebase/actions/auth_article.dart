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
}
