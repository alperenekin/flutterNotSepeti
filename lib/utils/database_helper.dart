import 'dart:io';
import 'package:flutter_not_sepeti/models/not.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:flutter_not_sepeti/models/category.dart';
class DatabaseHelper{
  //singleton demek sadece bir nesne kullanabilsin klası.
  static DatabaseHelper _databaseHelper;
  static Database _database;
  factory DatabaseHelper(){
    if(_databaseHelper==null){//koşul veya constructor da return varsa factory kullan
      return _databaseHelper=DatabaseHelper._internal();
    }
    else{
      return _databaseHelper;
    }
  }
  DatabaseHelper._internal();
  Future <Database> _getDatabase() async {
    if(_database==null){
      _database=await _initiliazeDatabase();
      return _database;
    }else{
      return _database;
    }
  }

  Future <Database> _initiliazeDatabase() async {
    var lock = Lock();
    Database _db;
      if (_db == null) {
        await lock.synchronized(() async {
          if (_db == null) {
            var databasesPath = await getDatabasesPath();
            var path = join(databasesPath, "appDB.db");
            print(path);
            var file = new File(path);

            // check if file exists
            if (!await file.exists()) {
              // Copy from asset
              ByteData data = await rootBundle.load(join("assets", "notlar.db"));
              List<int> bytes =
              data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
              await new File(path).writeAsBytes(bytes);
            }
            // open the database
            _db = await openDatabase(path);
          }
        });
      }

      return _db;
    }
  Future<List<Map<String,dynamic>>> getCategories() async{
    var db= await _getDatabase();
    var result = await db.query("kategori");
    return result;
  }
  Future<int> addCategory(Category category) async {
    var db = await _getDatabase();
    Future<int> result = db.insert("kategori", category.toMap());
    return result;
  }
  Future<int> updateCategory(Category category) async {
    var db = await _getDatabase();
    Future<int> result = db.update("kategori", category.toMap(),where: 'kategoriID = ?',whereArgs: [category.categoryID]);
    return result;
  }
  Future<int> deleteCategory(int categoryid) async { //only id is enough because we are deleting related id from database
    var db = await _getDatabase();
    Future<int> result = db.delete("kategori", where: 'kategoriID = ?',whereArgs: [categoryid]);
    return result;
  }

  Future<List<Map<String,dynamic>>> getNotes() async{ //içinde notlar bulunan liste döndürüyor
    var db= await _getDatabase();
    var result = await db.query("not",orderBy:"notID DESC" );
    return result;
  }
  Future<int> addNote(Not note) async {
    var db = await _getDatabase();
    Future<int> result = db.insert("not", note.toMap());
    return result;
  }
  Future<int> updateNote(Not note) async {
    var db = await _getDatabase();
    Future<int> result = db.update("not", note.toMap(),where: 'notID = ?',whereArgs: [note.categoryID]);
    return result;
  }
  Future<int> deleteNote(int notid) async { //only id is enough because we are deleting related id from database
    var db = await _getDatabase();
    Future<int> result = db.delete("not", where: 'notID = ?',whereArgs: [notid]);
    return result;
  }
}