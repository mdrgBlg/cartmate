// import 'package:flutter/material.dart';

enum Gender {
  male,
  female;

  ///TODO
  String genderName(
    // AppLocalizations localization
  ) => switch (this) {
    male => "Male",
    female => "Female",
  };
}

enum OrderStatus {
  pending,
  processing,
  inTransit,
  delivered;

  String get name => switch (this) {
    OrderStatus.pending => "Pending",
    OrderStatus.processing => "Processing",
    OrderStatus.inTransit => "In Transit",
    OrderStatus.delivered => "Delivered",
  };
}
