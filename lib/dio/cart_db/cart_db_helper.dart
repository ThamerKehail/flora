// import 'dart:io' as io;
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:ward/models/cart_model.dart';
//
// class CartDBHelper {
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
//     String path = join(documentDirectory.path, 'cart.db');
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
//       'CREATE TABLE cart (id INTEGER PRIMARY KEY,productId VARCHAR UNIQUE,productName TEXT,initialPrice DOUBLE,productPrice DOUBLE,quantity INTEGER,unitTag TEXT,image TEXT,businessId INTEGER,color INTEGER,message TEXT)',
//     );
//   }
//
//   Future<CartProduct> insert(CartProduct cart, int businessID) async {
//     var dbClient = await db;
//
//     await dbClient!.insert(
//       'cart',
//       cart.toMap(),
//     );
//
//     return cart;
//   }
//
//   Future<List<CartProduct>> getCartList() async {
//     var dbClient = await db;
//     final List<Map<String, Object?>> queryResult =
//         await dbClient!.query('cart');
//
//     return queryResult.map((e) => CartProduct.fromMap(e)).toList();
//   }
//
//   Future<bool> isProductExists(CartProduct cartProduct) async {
//     var dbClient = await db;
//     final queryResult = await dbClient!
//         .query('cart', where: 'id=?', whereArgs: [cartProduct.id]);
//     return queryResult.isNotEmpty;
//   }
//
//   Future<int> getProductCount(CartProduct cartProduct) async {
//     var dbClient = await db;
//     final queryResult = await dbClient!
//         .query('cart', where: 'productId = ?', whereArgs: [cartProduct.id]);
//     return queryResult.length;
//   }
//
//   Future<int> delete(int id) async {
//     var dbClient = await db;
//
//     return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future deleteAll() async {
//     var dbClient = await db;
//     return await dbClient!.delete(
//       'cart',
//     );
//   }
//
//   Future<int> updateQuantity(CartProduct cart) async {
//     var dbClient = await db;
//     return await dbClient!.update(
//       'cart',
//       cart.toMap(),
//       where: 'id=?',
//       whereArgs: [cart.id],
//     );
//   }
// }
