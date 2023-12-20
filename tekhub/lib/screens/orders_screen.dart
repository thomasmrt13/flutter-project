import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/widgets/orders/price_text.dart';
import 'package:tekhub/widgets/orders/spending_category.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Article> getArticles() {
      final List<Article> articles = <Article>[
        Article(
          id: '1',
          name: 'Iphone 12',
          price: 525,
          description: 'Iphone 12',
          type: ArticleType.phone,
          imageUrl: 'assets/images/ipad.png',
        ),
        Article(
          id: '2',
          name: 'Ipad Pro',
          price: 790,
          description: 'Ipad Pro 2021',
          type: ArticleType.tablet,
          imageUrl: 'assets/images/ipad.png',
        ),
        Article(
          id: '3',
          name: 'Iphone 14 Pro',
          price: 950,
          description: 'Iphone 14 Pro Max',
          type: ArticleType.phone,
          imageUrl: 'assets/images/ipad.png',
        ),
        Article(
          id: '4',
          name: 'Macbook Pro',
          price: 359,
          description: 'Macbook Pro 2022',
          type: ArticleType.laptop,
          imageUrl: 'assets/images/ipad.png',
        ),
      ];
      return articles;
    }

    final List<Article> articles = getArticles();
    double totalPrice = articles.fold(0, (sum, article) => sum + article.price);
    return Container(
      color: const Color.fromARGB(255, 39, 39, 39),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 180,
            child: Stack(children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                height: 150,
                padding: EdgeInsets.only(left: 36, top: 1),
                width: double.infinity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Orders',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway',
                          fontSize: 50,),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TOTAL',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 32),
                                PriceText(
                                  price: totalPrice.toInt(),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              articles.length.toString() + " SELLS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],),
              ),
            ],),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            child: SearchBar(),
          ),
          Expanded(
            child: ListView(children: [
              for (var model in articles)
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 16,),
                    child: SpendingCategory(model),),
            ],),
          ),
        ],
      ),
    );
  }
}
