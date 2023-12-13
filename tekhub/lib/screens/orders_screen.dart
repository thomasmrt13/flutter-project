import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/orders.dart';
import 'package:tekhub/widgets/orders/price_text.dart';
import 'package:tekhub/widgets/orders/spending_category.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const List<SpendingCategoryModel> categoryModels = <SpendingCategoryModel>[
    SpendingCategoryModel(
      'Ipad Pro',
      'assets/images/ipad.png',
      28,
      Color.fromARGB(255, 126, 217, 87),
    ),
    SpendingCategoryModel(
      'Ipad Pro',
      'assets/images/ipad.png',
      28,
      Color.fromARGB(255, 126, 217, 87),
    ),
    SpendingCategoryModel(
      'Ipod Pro',
      'assets/images/ipad.png',
      28,
      Color.fromARGB(255, 126, 217, 87),
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(left: 36, top: 12),
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 126, 217, 87),
                            borderRadius: BorderRadius.circular(32),),
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
                    ],),
              ),
            ],),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
            child: SearchBar(),
          ),
          Expanded(
            child: ListView(children: <Widget>[
              for (final SpendingCategoryModel model in categoryModels)
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
