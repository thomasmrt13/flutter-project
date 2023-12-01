import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatelessWidget {
  const SideBar(this.controller, {super.key});
  final SidebarXController controller;

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 39, 39, 39),
          title: const Text('Logout', style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                Navigator.pushNamed(context, 'login');
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Color.fromARGB(255, 126, 217, 87), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final Color? canvasColor = Colors.grey[200];
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 39, 39, 39),
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: const Color.fromARGB(255, 115, 115, 115),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold),
        selectedTextStyle: const TextStyle(color: const Color.fromARGB(255, 126, 217, 87)),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 126, 217, 87),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 126, 217, 87),
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 39, 39, 39),
        ),
      ),
      headerBuilder: (BuildContext context, bool extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      items: const <SidebarXItem>[
        SidebarXItem(
          icon: CupertinoIcons.home,
          label: 'Home',
        ),
        SidebarXItem(
          icon: CupertinoIcons.cart,
          label: 'Cart',
        ),
        SidebarXItem(
          icon: CupertinoIcons.cube_box,
          label: 'Orders',
        ),
        SidebarXItem(
          icon: CupertinoIcons.settings,
          label: 'Settings',
        ),
      ],
      footerBuilder: (BuildContext context, bool extended) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.square_arrow_left,
                color: Colors.white.withOpacity(0.7),
              ),
              onPressed: () async {
                await _showLogoutDialog(context);
              },
            ),
          ),
        );
      },
    );
  }
}
