import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    Key? key,
    required this.price,
    this.color = Colors.black,
  }) : super(key: key);

  final int price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var colorToUse = color;
    return Row(
      children: [
        Text(
          '\$$price',
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: colorToUse),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12, left: 0),
          child: Text('.30',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: colorToUse, fontSize: 16)),
        ),
      ],
    );
  }
}
