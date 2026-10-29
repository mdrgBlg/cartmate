// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Store app';

  @override
  String get loading => 'Loading...';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again';

  @override
  String get save => 'Save';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get gender => 'Gender';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get startShopping => 'Start shopping';

  @override
  String get errorViewTitle => 'Something went wrong';

  @override
  String get errorViewMessage => 'Check your connection and try again.';

  @override
  String get retry => 'Try again';

  @override
  String get navHome => 'Home';

  @override
  String get navStore => 'Store';

  @override
  String get navWishlist => 'Wishlist';

  @override
  String get navProfile => 'Profile';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusProcessing => 'Processing';

  @override
  String get orderStatusInTransit => 'In Transit';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get themeModeSystem => 'System default';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get authErrorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get authErrorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get authErrorUserNotFound => 'No account found for this email.';

  @override
  String get authErrorUserDisabled => 'This account has been disabled.';

  @override
  String get authErrorEmailAlreadyInUse =>
      'An account already exists for this email.';

  @override
  String get authErrorWeakPassword => 'The password is too weak.';

  @override
  String get authErrorTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get authErrorNetwork =>
      'Network error. Check your connection and try again.';

  @override
  String get authErrorOperationNotAllowed =>
      'This sign-in method is not enabled.';

  @override
  String get authErrorUnknown => 'Something went wrong. Please try again';

  @override
  String get homePopularProducts => 'Popular Products';

  @override
  String get homePopularCategories => 'Popular Categories';

  @override
  String get homeSearchHint => 'Search product...';

  @override
  String get searchNoResults => 'No products found';

  @override
  String get productStock => 'Stock: ';

  @override
  String get productInStock => 'In stock';

  @override
  String get productOutOfStock => 'Out of stock';

  @override
  String get productSize => 'Size';

  @override
  String get productAddToCart => 'Add to cart';

  @override
  String get productAddedToCart => 'Product is added to cart';

  @override
  String get productsEmptyTitle => 'No products found';

  @override
  String get productsEmptyMessage => 'There is nothing to show here yet.';

  @override
  String get myOrdersTitle => 'My Orders';

  @override
  String get myOrdersOrder => 'Order';

  @override
  String get myOrdersShippingDate => 'Shipping Date';

  @override
  String get myOrdersUnknown => 'Unknown';

  @override
  String get myOrdersEmptyTitle => 'No orders yet';

  @override
  String get myOrdersEmptyMessage =>
      'When you place an order, it will show up here.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileInformation => 'Profile information';

  @override
  String get profilePersonalInformation => 'Personal information';

  @override
  String get profileName => 'Name';

  @override
  String get profileUsername => 'Username';

  @override
  String get profileEmail => 'E-mail';

  @override
  String get profilePhoneNumber => 'Phone Number';

  @override
  String get profileDateOfBirth => 'Date of Birth';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileAppearance => 'Appearance';

  @override
  String get profileTheme => 'Theme';

  @override
  String profileChangeSection(String section) {
    return 'Change $section';
  }

  @override
  String profileSectionChanged(String section) {
    return 'User successfully changed $section';
  }

  @override
  String get cartTitle => 'Cart';

  @override
  String get cartEmptyTitle => 'Your cart is empty';

  @override
  String get cartEmptyMessage => 'Looks like you haven\'t added anything yet.';

  @override
  String get purchaseItemSize => 'Size: ';

  @override
  String get purchaseItemQuantity => 'Quantity: ';

  @override
  String checkoutButton(String price) {
    return 'Checkout $price';
  }

  @override
  String get checkoutOrderReview => 'Order review';

  @override
  String get checkoutSubtotal => 'Subtotal';

  @override
  String get checkoutShippingFee => 'Shipping fee';

  @override
  String get checkoutOrderTotal => 'Order total';

  @override
  String get checkoutPaymentMethod => 'Payment method';

  @override
  String get checkoutCash => 'Cash';

  @override
  String get checkoutShippingData => 'Shipping data';

  @override
  String get checkoutFirstName => 'First name:';

  @override
  String get checkoutLastName => 'Last name:';

  @override
  String get checkoutEmail => 'E-mail:';

  @override
  String get checkoutCountry => 'Country:';

  @override
  String get checkoutCountrySearchLabel => 'Search';

  @override
  String get checkoutCountrySearchHint => 'Start typing to search';

  @override
  String get checkoutCity => 'City:';

  @override
  String get checkoutZipCode => 'Zip code:';

  @override
  String get checkoutPhoneNumber => 'Phone number:';

  @override
  String get checkoutAddress => 'Address:';

  @override
  String get checkoutOrderReceived => 'Your order has been received!';

  @override
  String get checkoutOrderSaveError => 'Something went wrong. Please try again';

  @override
  String get storeTitle => 'Store';

  @override
  String get storeFeaturedBrands => 'Featured Brands';

  @override
  String get storeViewAll => 'View all';

  @override
  String get storeBrand => 'Brand';

  @override
  String get storeBrands => 'Brands';

  @override
  String get storeEmptyTitle => 'No brands yet';

  @override
  String get storeEmptyMessage => 'Brands for this category will show up here.';

  @override
  String storeProductsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'products',
      one: 'product',
    );
    return '$_temp0';
  }

  @override
  String get wishlistTitle => 'Wishlist';

  @override
  String get wishlistError => 'Error';

  @override
  String get wishlistEmptyTitle => 'Your wishlist is empty';

  @override
  String get wishlistEmptyMessage =>
      'Tap the heart on a product to save it here.';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email and we will send you a password reset link';

  @override
  String get forgotPasswordEmailHint => 'E-mail';

  @override
  String get forgotPasswordSubmit => 'Submit';

  @override
  String get forgotPasswordLinkSent =>
      'Link to reset your password is sent to your email';

  @override
  String get loginSignUp => 'Sign Up';

  @override
  String get loginTitle => 'Log In To CartMate';

  @override
  String get loginEmailHint => 'E - mail:';

  @override
  String get loginPasswordHint => 'Password:';

  @override
  String get loginButton => 'Log in';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginSuccess => 'You successfully logged in!';

  @override
  String get signUpUsername => 'Username';

  @override
  String get signUpEmail => 'E-mail';

  @override
  String get signUpPhoneNumber => 'Phone number';

  @override
  String get signUpPassword => 'Password:';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get signUpSuccess => 'You successfully signed up!';
}
