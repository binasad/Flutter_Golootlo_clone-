import 'package:flutter/material.dart';
import 'package:flutter_application_golootlo_clone/project/model/golootloModel.dart';
import 'package:flutter_application_golootlo_clone/project/screens/Page2ndGolootlo.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<restaurantMenu> _results = restaurantList;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  void _onSearch(String query) {
    setState(() {
      _results = query.trim().isEmpty
          ? restaurantList
          : restaurantList
              .where((r) =>
                  r.getName.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 111, 150, 182),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 159, 205, 243),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onSearch,
          decoration: const InputDecoration(
            hintText: 'Search restaurants...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
            prefixIcon: Icon(Icons.search, color: Colors.black54),
          ),
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                _onSearch('');
              },
            ),
        ],
      ),
      body: _results.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off, color: Colors.white54, size: 60),
                  SizedBox(height: 12),
                  Text(
                    'No restaurants found',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                return RestaurantCard(cardMenu: _results[index]);
              },
            ),
    );
  }
}
