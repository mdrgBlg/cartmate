import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants/themes.dart';
import 'firebase_options.dart';
import 'db/db_helper.dart';
import 'providers/main_provider.dart';
import 'screens/auth/welcome/welcome_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await DbHelper.database;

  runApp(
    ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "Store app",
      theme: Themes.themeData,
      home: const WelcomeScreen(),
    );
  }
}
