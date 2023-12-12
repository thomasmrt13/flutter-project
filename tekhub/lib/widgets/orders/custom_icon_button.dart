import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData? icon;

  const CustomIconButton({
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Color.fromARGB(255, 39, 39, 39)),
      // Wrap the IconButton in a Material widget for the
      // IconButton's splash to render above the container.
      child: Material(
        borderRadius: BorderRadius.circular(24),
        type: MaterialType.transparency,
        // Hard Edge makes sure the splash is clipped at the border of this
        // Material widget, which is circular due to the radius above.
        clipBehavior: Clip.hardEdge,
        child: IconButton(
          color: Color.fromARGB(255, 126, 217, 87),
          iconSize: 18,
          icon: Icon(
            icon ?? Icons.calendar_today,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
