import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/article_item.dart';
import 'package:tekhub/widgets/filter_bar.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({
    required this.searchtext,
    required this.articles,
    super.key,
  });

  final String searchtext;
  final List<Article> articles;

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    List<Article> filteredArticles = <Article>[];
    List<Article> filteredBarArticles = <Article>[];
    const bool isAdmin = false;

    return Consumer<ProviderListener>(
      builder: (
        BuildContext context,
        ProviderListener providerListener,
        Widget? child,
      ) {
        if (providerListener.searchtext.isNotEmpty) {
          filteredArticles = widget.articles
              .where(
                (Article article) => article.name
                    .toLowerCase()
                    .contains(providerListener.searchtext.toLowerCase()),
              )
              .toList();
          return Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextResult(
                    articlesLength: filteredArticles.length,
                    searchtext: providerListener.searchtext,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 32, right: 34, top: 20),
                      child: StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: List<StaggeredGridTile>.generate(
                          filteredArticles.length,
                          (int index) => StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 4,
                            child:
                                SingleArticle(article: filteredArticles[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          filteredBarArticles = widget.articles
              .where(
                (Article article) => article.type
                    .toString()
                    .contains(providerListener.activeType),
              )
              .toList();
          return Expanded(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    isAdmin == true
                        ? 'Manage your products'
                        : 'Find your product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: FilterBar(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 32, right: 34, top: 20),
                      child: StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: List<StaggeredGridTile>.generate(
                          providerListener.activeType == 'all'
                              ? widget.articles.length
                              : filteredBarArticles.length,
                          (int index) => StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 4,
                            child: SingleArticle(
                              article: providerListener.activeType == 'all'
                                  ? widget.articles[index]
                                  : filteredBarArticles[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class TextResult extends StatefulWidget {
  const TextResult({
    required this.searchtext,
    required this.articlesLength,
    super.key,
  });

  final String searchtext;
  final int articlesLength;

  @override
  TextResultState createState() => TextResultState();
}

class TextResultState extends State<TextResult> {
  @override
  Widget build(BuildContext context) {
    String text = '';
    if (widget.searchtext.isNotEmpty) {
      text = '${widget.articlesLength} results found';
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w600,
        fontFamily: 'Raleway',
      ),
    );
  }
}
