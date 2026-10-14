import '/models/cart_model.dart';

class CheckoutModel {
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
    required this.orderDate,
    required this.orderStatus,
    this.deliveryDate,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
    orderId: json["orderId"] as String,
    userId: json["userId"] as String,
    address: json["address"] as String,
    city: json["city"] as String,
    country: json["country"] as String,
    email: json["email"] as String,
    firstName: json["firstName"] as String,
    lastName: json["lastName"] as String,
    checkoutPrice: (json["checkoutPrice"] as num).toDouble(),
    postalCode: (json["postalCode"] as num).toInt(),
    items: (json["items"] as List<Map<String, dynamic>>)
        .map((e) => CartModel.fromJson(e))
        .toList(),
    orderDate: json["orderDate"] as String,
    deliveryDate: json["deliveryDate"] as String?,
    orderStatus: (json["orderStatus"] as num).toInt(),
  );

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
