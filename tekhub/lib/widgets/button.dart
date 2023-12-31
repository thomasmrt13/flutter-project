import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onClick,
    this.color,
    this.text = 'click',
    this.fontSize,
    this.width,
    this.height,
  });
  final VoidCallback? onClick;
  final Color? color;
  final String text;
  final double? fontSize;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: color,
      textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width, height: height),
      child: ElevatedButton(
        style: style,
        onPressed: onClick,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

class MediumButton extends Button {
  const MediumButton({
    super.key,
    super.text = 'click',
    super.onClick,
  }) : super(
          color: const Color(0xFF58C0EA),
          fontSize: 17,
          height: 50,
          width: 224,
        );
}

class LargeButton extends Button {
  const LargeButton({
    super.key,
    super.text = 'click',
    super.onClick,
  }) : super(
          color: const Color.fromARGB(255, 126, 217, 87),
          fontSize: 20,
          height: 70,
          width: 314,
        );
}
