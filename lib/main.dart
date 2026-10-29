import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/providers/theme_provider.dart';
import '/core/widgets/session_guard/session_guard.dart';
import 'app_dependencies.dart';
import 'firebase_options.dart';
import 'screens/auth/welcome/welcome_screen.dart';
import 'core/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Debug builds use the debug provider with the token passed via --dart-define,
  // or an auto-generated one. Release builds use Play Integrity / App Attest.
  const appCheckDebugToken = String.fromEnvironment('APP_CHECK_DEBUG_TOKEN');
  final debugToken = appCheckDebugToken.isEmpty ? null : appCheckDebugToken;
  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? AndroidDebugProvider(debugToken: debugToken)
        : const AndroidPlayIntegrityProvider(),
    providerApple: kDebugMode
        ? AppleDebugProvider(debugToken: debugToken)
        : const AppleAppAttestWithDeviceCheckFallbackProvider(),
  );

  runApp(
    MultiProvider(
      providers: [
        ...injectServiceDependencies(),
        ...injectRepositoryDependencies(),
        ...injectAppProviders(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, ThemeMode>(
      selector: (_, provider) => provider.themeMode,
      builder: (context, themeMode, _) => MaterialApp(
        navigatorKey: _navigatorKey,
        builder: (context, child) =>
            SessionGuard(navigatorKey: _navigatorKey, child: child!),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: Themes().getThemeData(),
        darkTheme: Themes().getDarkThemeData(),
        themeMode: themeMode,
        home: const WelcomeScreen(),
      ),
    );
  }
}
