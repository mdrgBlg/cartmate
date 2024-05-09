import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/brand_model.dart';

class StoreService {
  static Future<List<BrandModel>> fetchBrands() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<BrandModel> brandsList = [];
    try {
      final res = await db.collection("Brands").get();
      for (var e in res.docs) {
        BrandModel? brandModel = BrandModel.fromDocument(e);
        if (brandModel != null) {
          brandsList.add(brandModel);
        }
      }
    } catch (e) {
      log("EXCEPTION fetchBrands $e");
    }
    return brandsList;
  }
}
