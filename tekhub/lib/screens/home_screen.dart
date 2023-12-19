import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/screens/cart_screen.dart';
import 'package:tekhub/screens/orders_screen.dart';
import 'package:tekhub/screens/setting_screen.dart';
import 'package:tekhub/widgets/home_admin_widget.dart';
import 'package:tekhub/widgets/home_widget.dart';
import 'package:tekhub/widgets/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/provider/provider_listener.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: false);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (BuildContext context) {
          final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            backgroundColor: Colors.white,
            drawer: MediaQuery.of(context).size.width < 600
                ? SideBar(_controller)
                : SideBar(_controller),
            body: isSmallScreen
                ? buildSmallScreenBody(context)
                : buildSmallScreenBody(context),
          );
        },
      ),
    );
  }

  Widget buildSmallScreenBody(BuildContext context) {
    final MyUser user = Provider.of<ProviderListener>(context).user;

    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                switch (_controller.selectedIndex) {
                  case 0:
                    _key.currentState?.closeDrawer();
                    return user.role == 'user'
                        ? HomeWidget(
                            scaffoldKey: _key,
                          )
                        : const HomeAdminWidget();
                  case 1:
                    //_key.currentState?.closeDrawer();
                    return Center(
                      child: Cart(
                        scaffoldKey: _key,
                      ),
                    );
                  case 2:
                    //_key.currentState?.closeDrawer();
                    return OrdersScreen();
                  case 3:
                    //_key.currentState?.closeDrawer();
                    return const SettingsPage();
                  default:
                    return const Center(
                      child: Text(
                        'Home',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopHomeLayout extends StatelessWidget {
  const DesktopHomeLayout(this._controller, {super.key});
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SideBar(_controller);
  }
}
