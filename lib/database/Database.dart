/*
 * Copyright 2019 mybytecode
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';

import 'package:flutter_blog/Models/FavouriteArticleModel.dart';
import 'package:flutter_blog/Models/SavedArticleModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManagerForFavourites {
  final String favouriteArticlesTableName = "favourite_articles";

  DatabaseManagerForFavourites._();

  static final DatabaseManagerForFavourites databaseManager =
      DatabaseManagerForFavourites._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'mybytecode_blog.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $favouriteArticlesTableName(article_id INTEGER PRIMARY KEY,title varchar(255),category varchar(255),date varchar(255),content varchar(255),link varchar(255),image_url varchar(255))");
    }, version: 1);
  }

  Future<Database> insertFavouriteArticle(
      FavouriteArticleModel favouriteArticle) async {
    final databaseManager = await database;
    await databaseManager.insert(
        favouriteArticlesTableName, favouriteArticle.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<FavouriteArticleModel>> getFavouriteArticles() async {
    final databaseManager = await database;
    final List<Map<String, dynamic>> maps =
        await databaseManager.query(favouriteArticlesTableName);
    return List.generate(maps.length, (i) {
      return FavouriteArticleModel(
          articleId: maps[i]['article_id'],
          title: maps[i]['title'],
          category: maps[i]['category'],
          date: maps[i]['date'],
          content: maps[i]['content'],
          image_url: maps[i]['image_url'],
          link: maps[i]['link']);
    });
  }

  void deleteDatabase() async {
    final databaseManager = await database;

    await databaseManager
        .rawDelete("DELETE FROM $favouriteArticlesTableName where 1");
  }

  void deleteFavouriteArticle(int id) async {
    final databaseManager = await database;

    await databaseManager.rawDelete(
        "DELETE FROM $favouriteArticlesTableName where article_id = $id");
  }
}

class DatabaseManagerForSavedOffline {
  final String savedArticlesTableName = "saved_articles";

  DatabaseManagerForSavedOffline._();

  static final DatabaseManagerForSavedOffline databaseManager =
      DatabaseManagerForSavedOffline._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'mybytecode_blog.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $savedArticlesTableName(article_id INTEGER PRIMARY KEY,title varchar(255),category varchar(255),date varchar(255),content varchar(255),link varchar(255),image_url varchar(255))");
    }, version: 1);
  }

  Future<Database> insertSavedArticle(
      SavedArticlesModel savedArticlesModel) async {
    final databaseManager = await database;

    databaseManager.execute(
        "CREATE TABLE IF NOT EXISTS $savedArticlesTableName(article_id INTEGER PRIMARY KEY,title varchar(255),category varchar(255),date varchar(255),content varchar(255),link varchar(255),image_url varchar(255))");

    await databaseManager.insert(
        savedArticlesTableName, savedArticlesModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SavedArticlesModel>> getSavedArticles() async {
    final databaseManager = await database;
    final List<Map<String, dynamic>> maps = await databaseManager
        .rawQuery("SELECT * FROM $savedArticlesTableName ORDER BY date DESC");
    return List.generate(maps.length, (i) {
      return SavedArticlesModel(
          articleId: maps[i]['article_id'],
          title: maps[i]['title'],
          category: maps[i]['category'],
          date: maps[i]['date'],
          content: maps[i]['content'],
          image_url: maps[i]['image_url'],
          link: maps[i]['link']);
    });
  }

  void deleteSavedArticle(int id) async {
    final databaseManager = await database;

    await databaseManager.rawDelete(
        "DELETE FROM $savedArticlesTableName where article_id = $id");
  }
}
