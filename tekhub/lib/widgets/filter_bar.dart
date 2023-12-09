import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/provider/provider_listener.dart';

class FilterBar extends StatefulWidget {
  // Callback function

  const FilterBar({super.key});

  @override
  FilterBarState createState() => FilterBarState();
}

class FilterBarState extends State<FilterBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  void _handleTabSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Call the callback function with the selected type
    Provider.of<ProviderListener>(context, listen: false)
        .updateActiveType(_getSelectedType());
  }

  String _getSelectedType() {
    switch (_selectedIndex) {
      case 0:
        return 'all';
      case 1:
        return 'phone';
      case 2:
        return 'laptop';
      case 3:
        return 'tablet';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      const Tab(text: 'All'),
      const Tab(text: 'Phone'),
      const Tab(text: 'Laptop'),
      const Tab(text: 'Tablet'),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          ButtonsTabBar(
            backgroundColor: const Color(0xFF272727),
            unselectedBackgroundColor: const Color(0xFF272727),
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 126, 217, 87),
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            borderWidth: 2,
            unselectedBorderColor: const Color.fromARGB(255, 126, 217, 87),
            borderColor: const Color.fromARGB(255, 126, 217, 87),
            radius: 100,
            tabs: tabs,
            contentPadding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
            ),
            // Set the callback function as the onItemSelected
            onTap: _handleTabSelection,
          ),
        ],
      ),
    );
  }
}
