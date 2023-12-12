import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/orders.dart';
import 'package:tekhub/widgets/orders/price_text.dart';
import 'package:tekhub/widgets/orders/spending_category.dart';

class OrdersScreen extends StatelessWidget {
  static const categoryModels = [
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
      color: Color.fromARGB(255, 39, 39, 39),
      child: Column(
        children: [
          Container(
            height: 180,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                height: 150,
                padding: EdgeInsets.only(left: 36, top: 12),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Orders',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Raleway',
                          fontSize: 50),
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
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 126, 217, 87),
                            borderRadius: BorderRadius.circular(32)),
                      ),
                    ]),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 24),
            child: SearchBar(),
          ),
          Expanded(
            child: ListView(children: [
              for (var model in categoryModels)
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36.0, vertical: 16),
                    child: SpendingCategory(model))
            ]),
          ),
        ],
      ),
    );
  }
}
