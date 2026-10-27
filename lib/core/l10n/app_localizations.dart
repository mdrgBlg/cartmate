import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Store app'**
  String get appTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get somethingWentWrong;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get navStore;

  /// No description provided for @navWishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get navWishlist;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @orderStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderStatusPending;

  /// No description provided for @orderStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get orderStatusProcessing;

  /// No description provided for @orderStatusInTransit.
  ///
  /// In en, this message translates to:
  /// **'In Transit'**
  String get orderStatusInTransit;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found for this email.'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authErrorUserDisabled;

  /// No description provided for @authErrorEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already exists for this email.'**
  String get authErrorEmailAlreadyInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get authErrorTooManyRequests;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your connection and try again.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled.'**
  String get authErrorOperationNotAllowed;

  /// No description provided for @authErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get authErrorUnknown;

  /// No description provided for @homePopularProducts.
  ///
  /// In en, this message translates to:
  /// **'Popular Products'**
  String get homePopularProducts;

  /// No description provided for @homePopularCategories.
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get homePopularCategories;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search product...'**
  String get homeSearchHint;

  /// No description provided for @productStock.
  ///
  /// In en, this message translates to:
  /// **'Stock: '**
  String get productStock;

  /// No description provided for @productInStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get productInStock;

  /// No description provided for @productOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get productOutOfStock;

  /// No description provided for @productSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get productSize;

  /// No description provided for @productAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get productAddToCart;

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Product is added to cart'**
  String get productAddedToCart;

  /// No description provided for @myOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrdersTitle;

  /// No description provided for @myOrdersOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get myOrdersOrder;

  /// No description provided for @myOrdersShippingDate.
  ///
  /// In en, this message translates to:
  /// **'Shipping Date'**
  String get myOrdersShippingDate;

  /// No description provided for @myOrdersUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get myOrdersUnknown;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileInformation.
  ///
  /// In en, this message translates to:
  /// **'Profile information'**
  String get profileInformation;

  /// No description provided for @profilePersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get profilePersonalInformation;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileName;

  /// No description provided for @profileUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get profileUsername;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get profileEmail;

  /// No description provided for @profilePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profilePhoneNumber;

  /// No description provided for @profileDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileDateOfBirth;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileChangeSection.
  ///
  /// In en, this message translates to:
  /// **'Change {section}'**
  String profileChangeSection(String section);

  /// No description provided for @profileSectionChanged.
  ///
  /// In en, this message translates to:
  /// **'User successfully changed {section}'**
  String profileSectionChanged(String section);

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartTitle;

  /// No description provided for @purchaseItemSize.
  ///
  /// In en, this message translates to:
  /// **'Size: '**
  String get purchaseItemSize;

  /// No description provided for @purchaseItemQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity: '**
  String get purchaseItemQuantity;

  /// No description provided for @checkoutButton.
  ///
  /// In en, this message translates to:
  /// **'Checkout {price}'**
  String checkoutButton(String price);

  /// No description provided for @checkoutOrderReview.
  ///
  /// In en, this message translates to:
  /// **'Order review'**
  String get checkoutOrderReview;

  /// No description provided for @checkoutSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get checkoutSubtotal;

  /// No description provided for @checkoutShippingFee.
  ///
  /// In en, this message translates to:
  /// **'Shipping fee'**
  String get checkoutShippingFee;

  /// No description provided for @checkoutOrderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order total'**
  String get checkoutOrderTotal;

  /// No description provided for @checkoutPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get checkoutPaymentMethod;

  /// No description provided for @checkoutCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get checkoutCash;

  /// No description provided for @checkoutShippingData.
  ///
  /// In en, this message translates to:
  /// **'Shipping data'**
  String get checkoutShippingData;

  /// No description provided for @checkoutFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name:'**
  String get checkoutFirstName;

  /// No description provided for @checkoutLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name:'**
  String get checkoutLastName;

  /// No description provided for @checkoutEmail.
  ///
  /// In en, this message translates to:
  /// **'E-mail:'**
  String get checkoutEmail;

  /// No description provided for @checkoutCountry.
  ///
  /// In en, this message translates to:
  /// **'Country:'**
  String get checkoutCountry;

  /// No description provided for @checkoutCountrySearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get checkoutCountrySearchLabel;

  /// No description provided for @checkoutCountrySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Start typing to search'**
  String get checkoutCountrySearchHint;

  /// No description provided for @checkoutCity.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get checkoutCity;

  /// No description provided for @checkoutZipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip code:'**
  String get checkoutZipCode;

  /// No description provided for @checkoutPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number:'**
  String get checkoutPhoneNumber;

  /// No description provided for @checkoutAddress.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get checkoutAddress;

  /// No description provided for @checkoutOrderReceived.
  ///
  /// In en, this message translates to:
  /// **'Your order has been received!'**
  String get checkoutOrderReceived;

  /// No description provided for @checkoutOrderSaveError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get checkoutOrderSaveError;

  /// No description provided for @storeTitle.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get storeTitle;

  /// No description provided for @storeFeaturedBrands.
  ///
  /// In en, this message translates to:
  /// **'Featured Brands'**
  String get storeFeaturedBrands;

  /// No description provided for @storeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get storeViewAll;

  /// No description provided for @storeBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get storeBrand;

  /// No description provided for @storeBrands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get storeBrands;

  /// No description provided for @storeProductsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{product} other{products}}'**
  String storeProductsLabel(int count);

  /// No description provided for @wishlistTitle.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlistTitle;

  /// No description provided for @wishlistError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get wishlistError;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send you a password reset link'**
  String get forgotPasswordDescription;

  /// No description provided for @forgotPasswordEmailHint.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get forgotPasswordEmailHint;

  /// No description provided for @forgotPasswordSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get forgotPasswordSubmit;

  /// No description provided for @forgotPasswordLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Link to reset your password is sent to your email'**
  String get forgotPasswordLinkSent;

  /// No description provided for @loginSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get loginSignUp;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log In To CartMate'**
  String get loginTitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'E - mail:'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password:'**
  String get loginPasswordHint;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'You successfully logged in!'**
  String get loginSuccess;

  /// No description provided for @signUpUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get signUpUsername;

  /// No description provided for @signUpEmail.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get signUpEmail;

  /// No description provided for @signUpPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get signUpPhoneNumber;

  /// No description provided for @signUpPassword.
  ///
  /// In en, this message translates to:
  /// **'Password:'**
  String get signUpPassword;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @signUpSuccess.
  ///
  /// In en, this message translates to:
  /// **'You successfully signed up!'**
  String get signUpSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
