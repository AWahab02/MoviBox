import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user interface/themes/colors.dart';
import 'package:movies_tickets_task/user interface/widgets/my_app_bar.dart';
import 'package:movies_tickets_task/user%20interface/bottom_navbar/navbar.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../movies/trending.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List trendingMovies = [];
  final String apikey = "276110cc6e09716ff6c45f16fa626c5c";
  final readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNzYxMTBjYzZlMDk3MTZmZjZjNDVmMTZmYTYyNmM1YyIsInN1YiI6IjY1N2EwYzAyMzVhNjFlMDEzYWMyOTBmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vfW-6aMgcveWOeE8pjXTy-JVtIrsoxqXdHyRNabi4Rc";
  bool _showSearchBar = false;

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmbdwithLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingresult = await tmbdwithLogs.v3.movies.getUpcoming();
    setState(() {
      trendingMovies = trendingresult['results'];
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
                _showSearchBar ? Icons.arrow_back : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _showSearchBar = !_showSearchBar;
                });
              },
            ),
          ],
        ),
      ),
      body: TrendingMovies(trending: trendingMovies),
      bottomNavigationBar: CustomNavBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
