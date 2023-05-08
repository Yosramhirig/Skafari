import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ProductsListProvider extends ChangeNotifier{

  List<Map>? products;
  Database? database;

  ProductsListProvider(){
    createDatabase();
  }

  Future<void> createDatabase() async {
    var databasesPath = await getDatabasesPath();
    database = await openDatabase("myproducts.db", version: 1,
        onCreate: (Database db, int version) async {
          print("database created!");
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE product (id INTEGER PRIMARY KEY, barcode TEXT, productname TEXT, Image TEXT, done boolean)');
          print("table created!");
        },
        onOpen: (database) async {
          // Get the records
          products = await database.rawQuery('SELECT * FROM product');
          print("product: ${products.toString()}");
          print("database opened!");

        }
    );
  }

  Future<void> getproducts() async {
    products = await database?.rawQuery('SELECT * FROM product');
    notifyListeners();
  }

  Future<void> deleteproduct(int id) async {
    // Delete a record
    await database
        ?.rawDelete('DELETE FROM product WHERE id = $id');
    getproducts();
  }

  Future<void> insertToDatabase(String barcode,String productname,String Image ) async {
    if(await uidExists(barcode)){
      print("exists");
    }else{
      // Insert some records in a transaction
      await database?.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO product (barcode, productname, Image, done) VALUES("$barcode", "$productname", "$Image", 0)');
        print('inserted: $id1');
      });
    }

    getproducts();
  }

  Future<bool> uidExists(String barcode) async {
    var result = await database?.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM product WHERE barcode="$barcode")',
    );
    int? exists = Sqflite.firstIntValue(result!);
    return exists == 1;
  }

  Future<void> updatetodatabase( int id, int check) async {

    await database?.rawUpdate(
      'UPDATE product SET done = "$check" WHERE id = $id',
    );

    getproducts();
  }



}