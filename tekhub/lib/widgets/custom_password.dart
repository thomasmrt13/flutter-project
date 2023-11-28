import 'package:flutter/material.dart';

class CustomPassword extends StatelessWidget {
  const CustomPassword({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.lock_outline, size: 24, color: Colors.grey, semanticLabel: 'Email icon'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(color: Color(0xff868686), fontSize: 16),
                ),
              ),
            ],
          ),
          const TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              suffixText: 'Show',
              suffixStyle: TextStyle(color: Color.fromARGB(255, 126, 217, 87)),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
