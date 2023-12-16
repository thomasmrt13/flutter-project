import 'package:flutter/material.dart';

class CustomPassword extends StatelessWidget {
  CustomPassword({
    required this.title,
    super.key,
  });

  final String title;
  final TextEditingController _controller = TextEditingController();

  String getInputText() => _controller.text;

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '$title cannot be empty';
    }
    return null;
  }

  String? validateMatch(String? value, String? confirmPassword) {
    if (value != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.lock_outline,
                size: 24,
                color: Colors.grey,
                semanticLabel: 'Email icon',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(color: Color(0xff868686), fontSize: 16),
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
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
