class Article {
  Article({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.type,
    required this.imageUrl,
  });
  
  final String id;
  final String name;
  final double price;
  final String description;
  final ArticleType type;
  final String imageUrl;
}

enum ArticleType { phone, computer, tablet }
