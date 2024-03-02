import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '/models/response_model.dart';
import '/models/user_info_model.dart';

class MainProvider with ChangeNotifier {
  UserInfoModel? userInfoModel;

  Future<ResponseModel> fetchUserInfo(String userId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      final response = await db.collection("Users").doc(userId).get();
      if (response.data() != null) {
        userInfoModel = UserInfoModel.fromJson(response.data()!);
        return ResponseModel(success: true);
      }
      log("This user doesn't exist");
      return ResponseModel(success: false);
    } on FirebaseException catch (e) {
      log("FirebaseException fetchUserInfo: $e");
      return ResponseModel(success: false);
    } catch (e) {
      log("Exception fetchUserInfo: $e");
    }

    return ResponseModel(success: false);
  }
}
