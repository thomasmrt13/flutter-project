import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/search/search_bar.dart';
import 'package:tekhub/widgets/search/search_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  void getArticles() async {
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
        type: ArticleType.laptop,
        imageUrl: 'assets/images/logo.png',
      ),
    ];
    Provider.of<ProviderListener>(context, listen: false)
        .updateArticles(articles);
  }

  @override
  Widget build(BuildContext context) {
    getArticles();
    return Consumer<ProviderListener>(
      builder: (context, providerListener, child) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 62),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SearchBarComponent(),
                    ],
                  ),
                ),
              ),
              SearchResult(
                searchtext: providerListener.searchtext,
                articles: providerListener.articles,
              ),
            ],
          ),
        );
      },
    );
  }
}
