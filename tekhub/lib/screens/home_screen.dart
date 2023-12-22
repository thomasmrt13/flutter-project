import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/firebase/actions/article_service.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/screens/cart_screen.dart';
import 'package:tekhub/screens/orders_screen.dart';
import 'package:tekhub/screens/setting_screen.dart';
import 'package:tekhub/widgets/home_admin_widget.dart';
import 'package:tekhub/widgets/home_widget.dart';
import 'package:tekhub/widgets/side_bar.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchArticles();
    });
  }

  Future<void> _fetchArticles() async {
    final ArticleService articleService = ArticleService();
    final Result<dynamic> resultArticles =
        await articleService.getAllArticles();
    if (resultArticles.success) {
      if (!context.mounted) return;
      Provider.of<ProviderListener>(
        context,
        listen: false,
      ).updateArticles(resultArticles.message);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    return Center(
                      child: Cart(
                        scaffoldKey: _key,
                      ),
                    );
                  case 2:
                    return const OrdersScreen();
                  case 3:
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
