import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/models/user_history_articles.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';
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
    final MyUser user = Provider.of<ProviderListener>(context).user;
    final double total = user.purchaseHistory.fold(
        0,
        (double previousValue, UserHistoryArticles userHistoryArticle) =>
            previousValue + userHistoryArticle.article.price * userHistoryArticle.quantity,);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'TOTAL',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 32),
                      PriceText(
                        price: total.toInt(),
                        color: const Color.fromARGB(255, 255, 255, 255),
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
                for (final UserHistoryArticles model in user.purchaseHistory)
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
