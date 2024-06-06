import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/cart_model.dart';

class CheckoutModel {
  final String orderId;
  final String userId;
  final String address;
  final String city;
  final String country;
  final String email;
  final String firstName;
  final String lastName;
  final double checkoutPrice;
  final int postalCode;
  final List<CartModel?> items;
  final String? deliveryDate;
  final String orderDate;
  final int orderStatus;

  CheckoutModel({
    required this.orderId,
    required this.userId,
    required this.address,
    required this.city,
    required this.country,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.checkoutPrice,
    required this.postalCode,
    required this.items,
    this.deliveryDate,
    required this.orderDate,
    required this.orderStatus,
  });

  static CheckoutModel? fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data();
    CheckoutModel? checkoutModel;
    try {
      if (json != null) {
        checkoutModel = CheckoutModel(
          orderId: json["orderId"],
          userId: json["userId"],
          address: json["address"],
          city: json["city"],
          country: json["country"],
          email: json["email"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          checkoutPrice: json["checkoutPrice"],
          postalCode: json["postalCode"],
          items: (json["items"] as List)
              .map((e) => CartModel.fromJson(e))
              .toList(),
          orderDate: json["orderDate"],
          deliveryDate: json["deliveryDate"],
          orderStatus: json["orderStatus"],
        );
      }
    } catch (e) {
      log("EXCEPTION CheckoutModel $e");
    }
    return checkoutModel;
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "userId": userId,
      "address": address,
      "city": city,
      "country": country,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "checkoutPrice": checkoutPrice,
      "postalCode": postalCode,
      "items": items.map((e) => e?.toMap()).toList(),
      "deliveryDate": deliveryDate,
      "orderDate": orderDate,
      "orderStatus": orderStatus,
    };
  }
}
