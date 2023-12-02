import 'package:flutter/material.dart';

class ButtonMini extends StatelessWidget {
  const ButtonMini({super.key, this.text = 'Sky Blue', this.color = 0xff7485c1});
  final String text;
  final int color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shadowColor: Colors.black, elevation: 4, backgroundColor: Colors.white, foregroundColor: Colors.black),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Color(color)),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Raleway'),
          ),
        ],
      ),
    );
  }
}
