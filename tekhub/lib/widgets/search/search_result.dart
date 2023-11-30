import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/widgets/search/search_item.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({
    required this.searchtext,
    required this.articles,
    super.key,
  });

  final ValueNotifier<String> searchtext;
  final List<Article> articles;

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    List<Article> filteredArticles = <Article>[];

    return ValueListenableBuilder(
      valueListenable: widget.searchtext,
      builder: (BuildContext context, String value, Widget? child) {
        if (value.isNotEmpty) {
          filteredArticles = widget.articles
              .where(
                (Article article) =>
                    article.name.toLowerCase().contains(value.toLowerCase()),
              )
              .toList();
          return Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextResult(
                    articlesLength: filteredArticles.length,
                    searchtext: widget.searchtext,
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
                        children: List.generate(
                          filteredArticles.length,
                          (int index) => StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 4,
                            child: SearchItem(article: filteredArticles[index]),
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
          return Expanded(
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32, right: 34, top: 20),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      widget.articles.length,
                      (int index) => StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 4,
                        child: SearchItem(article: widget.articles[index]),
                      ),
                    ),
                  ),
                ),
              ),
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

  final ValueNotifier<String> searchtext;
  final int articlesLength;

  @override
  TextResultState createState() => TextResultState();
}

class TextResultState extends State<TextResult> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.searchtext,
      builder: (BuildContext context, String value, Widget? child) {
        String text = '';
        if (value.isNotEmpty) {
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
      },
    );
  }
}
