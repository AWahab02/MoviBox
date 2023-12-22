// use floor db to store movies

import 'package:floor/floor.dart';

@entity
class MovieDatabaseModel {
  @primaryKey
  final int id;
  final String original_title;
  final String? release_date;
  final String? overview;

  MovieDatabaseModel({
    required this.id,
    required this.original_title,
    this.release_date,
    this.overview,
  });
}

// store movies in local database

@dao
abstract class MovieDao {
  @Query('SELECT * FROM MovieDatabaseModel')
  Future<List<MovieDatabaseModel>> findAllMovies();

  @Query('SELECT * FROM MovieDatabaseModel WHERE id = :id')
  Future<MovieDatabaseModel?> findMovieById(int id);

  @insert
  Future<void> insertMovie(MovieDatabaseModel movie);
}
