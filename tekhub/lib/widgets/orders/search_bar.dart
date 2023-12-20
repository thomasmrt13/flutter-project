import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: CupertinoSearchTextField(
        borderRadius: BorderRadius.circular(16),
        placeholder: 'Search your spending',
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        placeholderStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
