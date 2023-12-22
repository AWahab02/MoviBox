import 'dart:async';

import 'package:floor/floor.dart';
import 'package:movies_tickets_task/database/dao.dart';
import 'package:movies_tickets_task/database/db.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'db.g.dart';

@Database(version: 1, entities: [MovieDatabaseModel])
abstract class LocalDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
