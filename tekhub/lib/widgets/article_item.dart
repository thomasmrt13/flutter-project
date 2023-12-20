import 'package:flutter/foundation.dart' show kIsWeb;
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
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.3,
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
                Positioned(
                  bottom:
                      kIsWeb ? MediaQuery.of(context).size.height * 0.15 : 25,
                  left: kIsWeb ? MediaQuery.of(context).size.width * 0.14 : 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      article.name,
                      style: const TextStyle(
                        fontSize: kIsWeb ? 25 : 22,
                        fontWeight: kIsWeb ? FontWeight.w800 : FontWeight.w600,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      kIsWeb ? MediaQuery.of(context).size.height * 0.13 : 8,
                  left: kIsWeb ? MediaQuery.of(context).size.width * 0.14 : 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '${article.price}€',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 126, 217, 87),
                        fontWeight: FontWeight.bold,
                        fontSize: kIsWeb ? 20 : 17,
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
