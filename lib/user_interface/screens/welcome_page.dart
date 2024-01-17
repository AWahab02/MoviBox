import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_tickets_task/provider/movie_provider.dart';
import 'package:movies_tickets_task/user_interface/themes/colors.dart';
import 'package:movies_tickets_task/user_interface/bottom_navbar/navbar.dart';
import 'package:movies_tickets_task/user_interface/movies/movies_list_offline.dart';
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
  late String apikey;
  final readaccesstoken = "";
  late TMDB tmdbWithLogs;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    final movieprovider = Provider.of<MovieProvider>(context, listen: false);
    apikey = dotenv.env['API_KEY'] ?? "";
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
          automaticallyImplyLeading: false,
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
