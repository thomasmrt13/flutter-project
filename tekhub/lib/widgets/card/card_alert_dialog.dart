import 'package:flutter/material.dart';

class CardAlertDialog extends StatelessWidget {
  const CardAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor:
            const Color.fromARGB(255, 39, 39, 39), // Set the background color to blue
        content: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40,
              top: -40,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Creditds Card Added',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'You can now use your card to make payments.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,),
                  ),
                ),
              ],
            ),
          ],
        ),);
  }
}
