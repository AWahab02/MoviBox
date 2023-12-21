import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user interface/themes/colors.dart';
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
  final readaccesstoken = "YOUR_ACCESS_TOKEN_HERE";
  late TMDB tmdbWithLogs;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    tmdbWithLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(
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
          title: const Text(
            'Top Rated',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: MoviesList(trending: trendingMovies),
      bottomNavigationBar: CustomNavBar(
        curr_index: 0,
      ),
    );
  }
}
