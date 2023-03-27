// import 'dart:io' as io;
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:ward/models/cart_model.dart';
// import 'package:ward/models/wishlist_model.dart';
//
// class WishlistDBHelper {
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
//     String path = join(documentDirectory.path, 'wishlist.db');
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
//       'CREATE TABLE wishlist (id INTEGER PRIMARY KEY,productId VARCHAR UNIQUE,productName TEXT,productPrice INTEGER,image TEXT)',
//     );
//   }
//
//   Future<Wishlist> insert(Wishlist wishlist) async {
//     var dbClient = await db;
//     await dbClient!.insert('wishlist', wishlist.toMap());
//     return wishlist;
//   }
//
//   Future<List<Wishlist>> getWishList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> queryResult =
//         await dbClient!.query('wishlist');
//
//     return queryResult.map((e) => Wishlist.fromMap(e)).toList();
//   }
//
//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient!.delete('wishlist', where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<int> updateQuantity(Wishlist wishlist) async {
//     var dbClient = await db;
//     return await dbClient!.update(
//       'wishlist',
//       wishlist.toMap(),
//       where: 'id=?',
//       whereArgs: [wishlist.id],
//     );
//   }
// }
