import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    required this.price, super.key,
    this.color = Colors.black,
  });

  final int price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color colorToUse = color;
    return Row(
      children: <Widget>[
        Text(
          '\$$price',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: colorToUse),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Text('.30',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: colorToUse, fontSize: 16),),
        ),
      ],
    );
  }
}
