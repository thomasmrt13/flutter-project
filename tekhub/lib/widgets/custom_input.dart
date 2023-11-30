import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  CustomInput({
    required this.title,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.icon,
    super.key,
  });

  final String title;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final IconData icon;

  final TextEditingController _controller = TextEditingController();

  String getInputText() => _controller.text;

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '$title cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon,
                  size: 24, color: Colors.grey, semanticLabel: 'Email icon'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style:
                      const TextStyle(color: Color(0xff868686), fontSize: 16),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _controller,
            validator: validateInput,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
