import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/search/search_bar.dart';
import 'package:tekhub/widgets/search_result.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({required this.scaffoldKey, super.key});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {
    const int cartItems = 0;
    return Consumer<ProviderListener>(
      builder: (
        BuildContext context,
        ProviderListener providerListener,
        Widget? child,
      ) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      const SearchBarComponent(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SearchResult(
                searchtext: providerListener.searchtext,
                articles: providerListener.articles,
              ),
            ],
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: const Color(0xFF272727),
                onPressed: () async {
                  await Navigator.pushNamed(context, 'cart');
                },
                child: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 126, 217, 87),
                ),
              ),
              if (cartItems > 0)
                Positioned(
                  top: -10,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 126, 217, 87),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItems.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
