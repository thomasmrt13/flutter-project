import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/widgets/search/search_bar.dart';
import 'package:tekhub/widgets/search/search_result.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> searchtext = ValueNotifier<String>('');
    final List<Article> articles = <Article>[
      Article(
        id: '1',
        name: 'Iphone 12',
        price: 525,
        description: 'Iphone 12',
        type: ArticleType.phone,
        imageUrl: 'assets/images/logo.png',
      ),
      Article(
        id: '2',
        name: 'Ipad Pro',
        price: 790,
        description: 'Ipad Pro 2021',
        type: ArticleType.tablet,
        imageUrl: 'assets/images/logo.png',
      ),
      Article(
        id: '3',
        name: 'Iphone 14 Pro',
        price: 950,
        description: 'Iphone 14 Pro Max',
        type: ArticleType.phone,
        imageUrl: 'assets/images/logo.png',
      ),
      Article(
        id: '4',
        name: 'Macbook Pro',
        price: 359,
        description: 'Macbook Pro 2022',
        type: ArticleType.computer,
        imageUrl: 'assets/images/logo.png',
      ),
    ];

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 29, top: 62),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                SearchBarComponent(
                  onTextChanged: (String text) {
                    // Handle the text change here
                    searchtext.value = text;
                  },
                ),
              ],
            ),
          ),
          SearchResult(
            searchtext: searchtext,
            articles: articles,
          ),
        ],
      ),
    );
  }
}
