import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:samachar/model/article_model.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = 'ArticleData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String dbPath = join(directory.path, _databaseName);

    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Article.tableArticle}(
        ${Article.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Article.colTitle} TEXT NOT NULL,
        ${Article.colDesc} TEXT NOT NULL,
        ${Article.colContent} TEXT NOT NULL,
        ${Article.colArticleUrl} TEXT NOT NULL,
        ${Article.colSource} TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertArticle(Article article) async {
    Database db = await database;
    return db.insert(Article.tableArticle, article.toMap());
  }


  Future<List<Article>> fetchArticles() async {
    Database db = await database;
    List<Map> x =
    await db.query(Article.tableArticle);
    return x.length == 0
        ? []
        : x.map((e) => Article.formMap(e)).toList();
  }

  Future<List<Article>> fetchArticlesinSeq() async {
    Database db = await database;
    List<Map> contacts =
    await db.query(Article.tableArticle, orderBy: '${Article.colTitle} ASC');//sort in ascending order
    return contacts.length == 0
        ? []
        : contacts.map((e) => Article.formMap(e)).toList();
  }

  Future close() async {
    Database db = await database;
    db.close();
  }

  deleteArticle(int id) async {
    Database db = await database;
    return db.delete(
      Article.tableArticle,
      where: '${Article.colId}=?',
      whereArgs: [id],
    );
  }
}
