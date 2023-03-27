// import 'dart:io' as io;
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:ward/models/bouquet.dart';
// import 'package:ward/models/bouquet_product_model.dart';
// import 'package:ward/models/cart_model.dart';
//
// class BouquetDBHelper {
//   static Database? _db;
//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDatabase();
//   }
//
//   initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'bouquet.db');
//     var db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//     return db;
//   }
//
//   _onCreate(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE bouquet (id INTEGER PRIMARY KEY,productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER,productPrice INTEGER,quantity INTEGER,image TEXT)',
//     );
//   }
//
//   Future<Bouquet> insert(Bouquet bouquet) async {
//     var dbClient = await db;
//     await dbClient!.insert('bouquet', bouquet.toMap());
//     return bouquet;
//   }
//
//   Future<List<Bouquet>> getBouquetList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> queryResult =
//         await dbClient!.query('bouquet');
//     return queryResult.map((e) => Bouquet.fromMap(e)).toList();
//   }
//
//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient!.delete('bouquet', where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<int> updateQuantity(Bouquet bouquet) async {
//     var dbClient = await db;
//     return await dbClient!.update(
//       'bouquet',
//       bouquet.toMap(),
//       where: 'id=?',
//       whereArgs: [bouquet.id],
//     );
//   }
// }
