import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    this.price = 0,
    this.title = 'Title of the product',
    this.assetPath = '',
  });
  final double price;
  final String title;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(assetPath),
              width: 80,
              height: 105,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  '\u0024$price',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color.fromARGB(255, 126, 217, 87),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Text('Quantity: '),
                    const Text(
                      '1',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '-',
                        style: TextStyle(color: Colors.red, fontSize: 40),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '+',
                        style: TextStyle(color: Colors.green, fontSize: 40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
