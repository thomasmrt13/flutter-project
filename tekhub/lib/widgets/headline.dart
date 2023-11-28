import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({super.key, this.title = ''});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontFamily: 'Raleway', color: Colors.white, fontSize: 65, fontWeight: FontWeight.bold), textAlign: TextAlign.center);
  }
}
