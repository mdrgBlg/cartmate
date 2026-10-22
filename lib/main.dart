import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/constants/themes.dart';
import 'di/app_dependencies.dart';
import 'firebase_options.dart';
import 'screens/auth/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: const AndroidDebugProvider(),
  );

  runApp(
    MultiProvider(
      providers: [
        ...injectServiceDependencies(),
        ...injectRepositoryDependencies(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('en')],
      debugShowCheckedModeBanner: false,
      title: "Store app",
      theme: Themes.themeData,
      home: const WelcomeScreen(),
    );
  }
}
