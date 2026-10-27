import '/core/l10n/app_localizations.dart';

enum Gender {
  male,
  female;

  String genderName(AppLocalizations localization) => switch (this) {
    male => localization.genderMale,
    female => localization.genderFemale,
  };
}

enum OrderStatus {
  pending,
  processing,
  inTransit,
  delivered;

  String statusName(AppLocalizations localization) => switch (this) {
    OrderStatus.pending => localization.orderStatusPending,
    OrderStatus.processing => localization.orderStatusProcessing,
    OrderStatus.inTransit => localization.orderStatusInTransit,
    OrderStatus.delivered => localization.orderStatusDelivered,
  };
}
