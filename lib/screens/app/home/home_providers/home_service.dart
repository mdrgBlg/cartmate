import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';

import '../home_models/categories_model.dart';
import '../home_models/products_model.dart';
import '/db/db_constants.dart';
import '/db/db_helper.dart';
import '/models/brand_model.dart';

class HomeService {
  static Future<List<CategoriesModel>> fetchCategories() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<CategoriesModel> categoryList = [];
    try {
      final res = await db.collection("Categories").get();
      for (var e in res.docs) {
        final categoriesModel = CategoriesModel.fromDocument(
          id: e.id,
          json: e.data(),
        );
        if (categoriesModel.parentId == null) {
          categoryList.add(categoriesModel);
        }
      }
    } catch (e) {
      log("EXCEPTION fetchCategories $e");
    }

    return categoryList;
  }

  static Future<List<ProductsModel>> fetchProducts() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<ProductsModel> productList = [];
    try {
      final res = await db.collection("Products").get();
      for (var e in res.docs) {
        final productsModel = ProductsModel.fromDocument(
          id: e.id,
          json: e.data(),
        );
        productList.add(productsModel);
      }
    } catch (e) {
      log("EXCEPTION fetchProducts $e");
    }

    return productList;
  }

  static Future<bool> addProductToWhishlist(Map<String, dynamic> map) async {
    log(map.toString());
    try {
      int? result = await DbHelper.db?.insert(
        DbConstants.whishlistTable,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (result == null || result == -1) {
        log('Insert operation failed for $map');
        return false;
      } else {
        log('Insert successful with row id: $result');
        return true;
      }
    } catch (e) {
      log("EXCEPTION addProductToWhishlist $map");
    }
    return false;
  }

  static Future<bool> addBrand(Map<String, dynamic> map) async {
    log(map.toString());
    try {
      int? result = await DbHelper.db?.insert(
        DbConstants.brandTable,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (result == null || result == -1) {
        log('Insert operation failed for $map');
        return false;
      } else {
        log('Insert successful with row id: $result');
        return true;
      }
    } catch (e) {
      log("EXCEPTION addBrand $map");
    }
    return false;
  }

  static Future<List<ProductsModel>> fetchWhishlistProducts() async {
    List<ProductsModel> productsList = [];
    BrandModel? brandModel;
    try {
      final List<Map<String, dynamic>>? productsMap = await DbHelper.db?.query(
        DbConstants.whishlistTable,
      );
      if (productsMap != null && productsMap.isNotEmpty) {
        log(
          "Data successfully fetched from ${DbConstants.whishlistTable} table",
        );
        for (var e in productsMap) {
          final brandId = e["brandId"];
          final List<Map<String, dynamic>>? brandMap = await DbHelper.db?.query(
            DbConstants.brandTable,
            where: 'id = ?',
            whereArgs: [brandId],
          );

          if (brandMap != null && brandMap.isNotEmpty) {
            log(
              "Data successfully fetched from ${DbConstants.brandTable} table",
            );
            brandModel = BrandModel.fromJsonDb(brandMap.first);
          }
          ProductsModel? productsModel = ProductsModel.fromDb(e, brandModel);
          productsList.add(productsModel);
        }
      } else {
        log(
          "Error fetching data or table is empty (${DbConstants.whishlistTable} table)",
        );
      }
    } catch (e) {
      log("EXCEPTION fetchWhishlistProducts $e");
    }
    return productsList;
  }
}
