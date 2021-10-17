// import 'dart:async';
// import 'package:athmany/providers/orders.dart';
// import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart' as sql;
//
// class DBHelper {
//   static Future<void> insert(String table, Map<String, Object> data) async {
//     final dbPath = await sql.getDatabasesPath();
//     final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
//         onCreate: (db, version) {
//       return db.execute(
//         'CREATE TABLE ',
//       );
//     });
//   }
// }
