import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../database/dao.dart';
import '../database/db.dart';

class MovieProvider with ChangeNotifier {
  List _trending = [];

  List get trending => _trending;

  List TopRatedMovies = [];

  List upcomingMovies = [];

  List moviesToShow = [];

  List searchedMovies = [];

  bool showSearchBar = false;

  bool connected = true;
  late TMDB tmdbWithLogs;

  void updateTrending(List newTrending) {
    _trending = newTrending;
  }

  loadMoviesTopRated({String? query}) async {
    Map result;
    if (query != null && query.isNotEmpty) {
      result = await tmdbWithLogs.v3.search.queryMovies(query);
    } else {
      result = await tmdbWithLogs.v3.movies.getTopRated();
    }

    TopRatedMovies = result['results'];
    notifyListeners();
    print(TopRatedMovies);
  }

  loadMoviesUpcoming({String? query}) async {
    Map result;

    if (query != null && query.isNotEmpty) {
      result = await tmdbWithLogs.v3.search.queryMovies(query);
    } else {
      result = await tmdbWithLogs.v3.movies.getUpcoming();
    }

    upcomingMovies = result['results'];
    notifyListeners();
    print(TopRatedMovies);
  }

  getupcomingmovies({String? query}) async {
    connected = await InternetConnectionChecker().hasConnection;
    if (connected) {
      loadMoviesUpcoming(query: query).then((value) => saveMoviesToDb());
    } else {
      getMoviesFromDb();
    }
  }

  loadSearchedMovies({String? query}) async {
    Map result;
    result = await tmdbWithLogs.v3.search.queryMovies(query!);

    searchedMovies = result['results'];
    notifyListeners();
    print(searchedMovies);
  }

  void saveMoviesToDb() async {
    final database =
        await $FloorLocalDatabase.databaseBuilder('moviesDatabase.db').build();
    final movieDao = database.movieDao;

    for (var movie in upcomingMovies) {
      MovieDatabaseModel? movieModel =
          await movieDao.findMovieById(movie['id']);

      if (movieModel == null) {
        // log("${movie['original_title']} saved to database");

        MovieDatabaseModel movieDatabaseModel = MovieDatabaseModel(
          id: movie['id'],
          original_title: movie['original_title'],
          overview: movie['overview'],
          release_date: movie['release_date'],
        );

        await movieDao.insertMovie(movieDatabaseModel);
      } else {
        // log("${movie.movie.original_title} already saved to database");
      }
    }

    notifyListeners();
  }

  void getMoviesFromDb() async {
    final database =
        await $FloorLocalDatabase.databaseBuilder('moviesDatabase.db').build();
    final movieDao = database.movieDao;
    List<MovieDatabaseModel> moviesToShowList = await movieDao.findAllMovies();
    moviesToShow = moviesToShowList;
    notifyListeners();
  }
}
