import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_tickets_task/user_interface/themes/colors.dart';
import 'package:movies_tickets_task/user_interface/bottom_navbar/navbar.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../provider/movie_provider.dart';
import '../movies/movies_list.dart';
import '../movies/movies_list_offline.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  List searchedMovies = [];
  late String apikey;
  final readaccesstoken = "";
  bool _showSearchBar = false;
  late TMDB tmdbWithLogs;
  final TextEditingController _searchController = TextEditingController();
  late bool connected;

  @override
  void initState() {
    final movieprovider = Provider.of<MovieProvider>(context, listen: false);
    apikey = dotenv.env['API_KEY'] ?? "";
    tmdbWithLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    movieprovider.gettopratedmovies();
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
      searchedMovies = result['results'];
    });
    print(searchedMovies);
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
                    loadMovies();
                  }
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
          ],
          automaticallyImplyLeading: false,
        ),
      ),
      body: _showSearchBar
          ? Consumer<MovieProvider>(
              builder: (context, value, child) {
                return MoviesList(listofMovies: value.searchedMovies);
              },
            )
          : Consumer<MovieProvider>(
              builder: (context, value, child) {
                if (value.connected) {
                  return MoviesList(listofMovies: value.TopRatedMovies);
                } else {
                  return MoviesListOffline(listofMovies: value.moviesToShow);
                }
              },
            ),
      bottomNavigationBar: const CustomNavBar(
        curr_index: 1,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        onChanged: (query) {
          Provider.of<MovieProvider>(context, listen: false)
              .loadSearchedMovies(query: query);
        },
        decoration: const InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
