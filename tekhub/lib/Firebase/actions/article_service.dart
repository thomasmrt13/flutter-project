import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';

class ArticleService {
  Future<Result<dynamic>> getAllArticles() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance.collection('articles').get();

      final List<Article> articles = articlesSnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        return Article(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          description: data['description'] ?? '',
          type: _parseArticleType(data['type']),
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();

      return Result<dynamic>.success(
        articles,
      ); // Return successful result with articles
    } catch (e) {
      return Result<dynamic>.failure(
        'Error getting articles',
      ); // Return failure result with error message
    }
  }

  ArticleType _parseArticleType(String type) {
    switch (type) {
      case 'phone':
        return ArticleType.phone;
      case 'laptop':
        return ArticleType.laptop;
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
      case ArticleType.laptop:
        return 'laptop';
      case ArticleType.tablet:
        return 'tablet';
    }
  }

  Future<Result<dynamic>> getArticleById(String articleId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> articleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .doc(articleId)
              .get();

      if (!articleSnapshot.exists) {
        return Result<dynamic>.failure(
          'Article not found',
        ); // Return failure result with error message
      }

      final Map<String, dynamic> data = articleSnapshot.data()!;
      final Article article = Article(
        id: articleSnapshot.id,
        name: data['name'] ?? '',
        price: (data['price'] ?? 0.0).toDouble(),
        description: data['description'] ?? '',
        type: _parseArticleType(data['type']),
        imageUrl: data['imageUrl'] ?? '',
      );

      return Result<dynamic>.success(
        article,
      ); // Return successful result with the article
    } catch (e) {
      return Result<dynamic>.failure(
        'Error getting article',
      ); // Return failure result with error message
    }
  }

  Future<Result<dynamic>> searchArticles(String query) async {
    try {
      // Convert the query to lowercase for case-insensitive comparison
      final String lowercaseQuery = query.toLowerCase();

      // Create an array of substrings from the query
      final List<String> querySubstrings = <String>[];
      for (int i = 1; i <= lowercaseQuery.length; i++) {
        querySubstrings.add(lowercaseQuery.substring(0, i));
      }

      // Use array-contains-any to match any substring
      final QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('searchKeywords', arrayContainsAny: querySubstrings)
              .get();

      final List<Article> articles = articlesSnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        return Article(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          description: data['description'] ?? '',
          type: _parseArticleType(data['type']),
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();

      return Result<dynamic>.success(
        articles,
      ); // Return successful result with the matching articles
    } catch (e) {
      return Result<dynamic>.failure(
        'Error searching articles',
      ); // Return failure result with error message
    }
  }

  Future<Result<dynamic>> getArticlesByFilter(ArticleType filterType) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('type', isEqualTo: _mapArticleTypeToString(filterType))
              .get();

      final List<Article> articles = articlesSnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        return Article(
          id: doc.id,
          name: data['name'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          description: data['description'] ?? '',
          type: _parseArticleType(data['type']),
          imageUrl: data['imageUrl'] ?? '',
        );
      }).toList();

      return Result<dynamic>.success(
        articles,
      ); // Return successful result with the matching articles
    } catch (e) {
      return Result<dynamic>.failure(
        'Error getting articles by filter',
      ); // Return failure result with error message
    }
  }

  Future<Result<dynamic>> addArticle(
    String? name,
    double price,
    String? description,
    String? type,
    String imageUrl,
  ) async {
    // get all parameters in add article with string...
    try {
      if (name == null) {
        return Result<dynamic>.failure(
          'Invalid article data. Name is required.',
        );
      }

      if (price <= 0) {
        return Result<dynamic>.failure(
          'Invalid article data. Price is required.',
        );
      }

      if (type == null) {
        return Result<dynamic>.failure(
          'Invalid article data. Type is required.',
        );
      }

      await FirebaseFirestore.instance
          .collection('articles')
          .add(<String, dynamic>{
        'name': name,
        'price': price,
        'description': description,
        'type': type,
        'imageUrl': imageUrl,
      });
      return Result<dynamic>.success('Article added successfully');
    } catch (e) {
      return Result<dynamic>.failure('Error adding article: $e');
    }
  }

  Future<Result<dynamic>> updateArticle({
    required String articleId,
    required String name,
    required double price,
    required String imageUrl,
    String? description,
  }) async {
    try {
      // Validate input parameters
      if (name.isEmpty) {
        return Result<dynamic>.failure(
            'Invalid article data. Name is required.',);
      }

      if (price <= 0) {
        return Result<dynamic>.failure(
            'Invalid article data. Price must be greater than zero.',);
      }

      // Update article in Firestore
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(articleId)
          .update(<Object, Object?>{
        'name': name,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
      });

      return Result<dynamic>.success('Article updated successfully');
    } catch (e) {
      return Result<dynamic>.failure('Error updating article: $e');
    }
  }

  Future<Result<dynamic>> deleteArticle(String articleId) async {
    try {
      // Delete article from Firestore
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(articleId)
          .delete();

      return Result<dynamic>.success('Article deleted successfully');
    } catch (e) {
      return Result<dynamic>.failure('Error deleting article: $e');
    }
  }
}
