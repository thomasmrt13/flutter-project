import 'package:flutter/material.dart';

class CustomPassword extends StatelessWidget {
  const CustomPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.lock_outline, size: 24, color: Colors.grey, semanticLabel: 'Email icon'),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Passcode',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16),
                ),
              ),
            ],
          ),
          TextField(
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
