import 'package:flutter/material.dart';
import 'package:movies_tickets_task/provider/movie_provider.dart';
import 'package:movies_tickets_task/user interface/themes/colors.dart';
import 'package:movies_tickets_task/user%20interface/bottom_navbar/navbar.dart';
import 'package:movies_tickets_task/user%20interface/movies/movies_list_offline.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../movies/movies_list.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // List TopRatedMovies = [];
  final String apikey = "276110cc6e09716ff6c45f16fa626c5c";
  final readaccesstoken = "YOUR_ACCESS_TOKEN_HERE";
  late TMDB tmdbWithLogs;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    final movieprovider = Provider.of<MovieProvider>(context, listen: false);
    movieprovider.tmdbWithLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    movieprovider.getupcomingmovies();
    super.initState();
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
            'Upcoming',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, value, child) {
          if (value.connected) {
            return MoviesList(listofMovies: value.upcomingMovies);
          } else {
            print(value.moviesToShow);
            return MoviesListOffline(listofMovies: value.moviesToShow);
          }
        },
      ),
      bottomNavigationBar: const CustomNavBar(
        curr_index: 0,
      ),
    );
  }
}
