import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/provider/provider_listener.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  SearchBarComponentState createState() => SearchBarComponentState();
}

class SearchBarComponentState extends State<SearchBarComponent> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderListener>(context, listen: false)
        .updateActiveType('all');
    return SizedBox(
      width: kIsWeb
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        onSubmitted: (String value) {},
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: _searchText.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchText = '';
                    });
                  },
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
        Provider.of<ProviderListener>(context, listen: false)
            .updateSearchText(_searchController.text);
      });
    });
  }
}
