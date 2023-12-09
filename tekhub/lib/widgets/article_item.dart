import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/screens/product_detail_screen.dart';

class SingleArticle extends StatelessWidget {
  const SingleArticle({required this.article, super.key});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.elliptical(20, 20)),
          splashColor: Colors.white,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SingleItem(article: article),
              ),
            );
          },
          child: SizedBox(
            width: 156,
            height: 252,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: const Alignment(-0.9, -1.7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(article.imageUrl),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 31),
                    child: Text(
                      article.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 98, bottom: 31),
                  child: Center(
                    child: Text(
                      '${article.price}€',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 126, 217, 87),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
