// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tekhub/Firebase/actions/image_service.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';

class ArticleService {
  Future<Result> getAllArticles() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance.collection('articles').get();

      final List<Article> articles = articlesSnapshot.docs.map((doc) {
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

      return Result(true, articles); // Return successful result with articles
    } catch (e) {
      return Result(
        false,
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

  Future<Result> getArticleById(String articleId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> articleSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .doc(articleId)
              .get();

      if (!articleSnapshot.exists) {
        return Result(
          false,
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

      return Result(true, article); // Return successful result with the article
    } catch (e) {
      return Result(
        false,
        'Error getting article',
      ); // Return failure result with error message
    }
  }

  Future<Result> searchArticles(String query) async {
    try {
      // Convert the query to lowercase for case-insensitive comparison
      final String lowercaseQuery = query.toLowerCase();

      // Create an array of substrings from the query
      final List<String> querySubstrings = [];
      for (int i = 1; i <= lowercaseQuery.length; i++) {
        querySubstrings.add(lowercaseQuery.substring(0, i));
      }

      // Use array-contains-any to match any substring
      final QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('searchKeywords', arrayContainsAny: querySubstrings)
              .get();

      final List<Article> articles = articlesSnapshot.docs.map((doc) {
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

      return Result(
        true,
        articles,
      ); // Return successful result with the matching articles
    } catch (e) {
      return Result(
        false,
        'Error searching articles',
      ); // Return failure result with error message
    }
  }

  Future<Result> getArticlesByFilter(ArticleType filterType) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> articlesSnapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('type', isEqualTo: _mapArticleTypeToString(filterType))
              .get();

      final List<Article> articles = articlesSnapshot.docs.map((doc) {
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

      return Result(
        true,
        articles,
      ); // Return successful result with the matching articles
    } catch (e) {
      return Result(
        false,
        'Error getting articles by filter',
      ); // Return failure result with error message
    }
  }

  Future<Result> addArticle(Article article, File imageFile) async {
    try {
      if (article.name.isEmpty) {
        return Result(false, 'Invalid article data. Name is required.');
      }

      if (article.price <= 0) {
        return Result(false, 'Invalid article data. Price is required.');
      }

      // ignore: unnecessary_null_comparison
      if (article.type == null) {
        return Result(false, 'Invalid article data. Type is required.');
      }

      // Convert the ArticleType enum to its corresponding string value
      final String typeString = _mapArticleTypeToString(article.type);

      // Upload image to Firebase Storage and get the image URL
      final String? imageUrl =
          await ImageService().addImageToStorage(imageFile);

      if (imageUrl == null) {
        return Result(false, 'Error uploading image.');
      }

      // Add the article information to Firestore with the image URL
      await FirebaseFirestore.instance.collection('articles').add({
        'name': article.name,
        'price': article.price,
        'description': article.description,
        'type': typeString,
        'imageUrl': imageUrl,
      });

      return Result(true, 'Article added successfully');
    } catch (e) {
      return Result(false, 'Error adding article: $e');
    }
  }
}
