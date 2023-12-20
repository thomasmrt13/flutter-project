import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/widgets/orders/custom_icon_button.dart';
import 'package:tekhub/widgets/orders/price_text.dart';

class SpendingCategory extends StatelessWidget {
  final Article data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: <Widget>[
          Container(
            height: 100,
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 32,
                  color: Colors.black45,
                  spreadRadius: -8,
                ),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(data.imageUrl, width: 64),
                PriceText(price: data.price.toInt()),
                Row(children: [
                  CustomIconButton(icon: Icons.delete),
                  SizedBox(width: 8),
                ])
              ],
            ),
          ),
          Container(
            width: 132,
            height: 24,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 126, 217, 87),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Text(
              data.name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
