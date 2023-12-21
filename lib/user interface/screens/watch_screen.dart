import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user interface/themes/colors.dart';
import 'package:movies_tickets_task/user interface/widgets/my_app_bar.dart';
import 'package:movies_tickets_task/user%20interface/bottom_navbar/navbar.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../movies/movies_list.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  List trendingMovies = [];
  final String apikey = "276110cc6e09716ff6c45f16fa626c5c";
  final readaccesstoken = "YOUR_ACCESS_TOKEN_HERE";
  bool _showSearchBar = false;
  late TMDB tmdbWithLogs;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    tmdbWithLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    loadMovies();
    super.initState();
  }

  loadMovies({String? query}) async {
    Map result;
    if (query != null && query.isNotEmpty) {
      result = await tmdbWithLogs.v3.search.queryMovies(query);
    } else {
      result = await tmdbWithLogs.v3.movies.getTopRated();
    }

    setState(() {
      trendingMovies = result['results'];
    });
    print(trendingMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: kAppBarBackgroundColor,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showSearchBar
                ? _buildSearchBar()
                : const Text(
                    'Watch',
                    style: TextStyle(color: Colors.black),
                  ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _showSearchBar ? Icons.clear : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (_showSearchBar) {
                    _searchController.clear();
                    loadMovies(); // Reset to show trending movies
                  }
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
          ],
        ),
      ),
      body: MoviesList(listofMovies: trendingMovies),
      bottomNavigationBar: CustomNavBar(
        curr_index: 1,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          loadMovies(query: query);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
