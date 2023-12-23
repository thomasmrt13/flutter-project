import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/widgets/orders/price_text.dart';
import 'package:tekhub/widgets/orders/spending_category.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({required this.scaffoldKey, super.key});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
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
    return ColoredBox(
      color: const Color.fromARGB(255, 39, 39, 39),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 12),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  widget.scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'My orders',
                style: TextStyle(fontFamily: 'Raleway', fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 126, 217, 87),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'TOTAL',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 32),
                      PriceText(
                        price: 100,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            child: SearchBar(),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                for (final Article model in articles)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 16,
                    ),
                    child: SpendingCategory(model),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
