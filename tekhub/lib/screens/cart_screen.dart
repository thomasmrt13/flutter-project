import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/button.dart';
import 'package:tekhub/widgets/cart_item.dart';
import 'package:tekhub/widgets/side_bar.dart';

class Cart extends StatefulWidget {
  const Cart({required this.scaffoldKey, super.key});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final List<Article> articles = Provider.of<ProviderListener>(context).articles;
    final double total = articles.fold(0, (double previousValue, Article article) => previousValue + article.price);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      body: Column(
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
                'My Cart',
                style: TextStyle(fontFamily: 'Raleway', fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.55,
            child: Expanded(
              child: ListView(
                children: articles.map((Article article) {
                  return CartItem(
                    assetPath: article.imageUrl,
                    title: article.name,
                    price: article.price,
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'Total',
                style: TextStyle(fontSize: 17, fontFamily: 'Raleway', color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 126, 217, 87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          LargeButton(
            text: 'Checkout',
            onClick: () async {
              await Navigator.pushNamed(context, 'checkout');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DesktopCartLayout extends StatelessWidget {
  const DesktopCartLayout(this._controller, {super.key});
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SideBar(_controller);
  }
}
