import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/screens/auth/welcome/welcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/auth/welcome/welcome_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: "Store app",
      theme: Themes.lightTheme,
      home: ChangeNotifierProvider(
        create: (context) => WelcomeProvider(),
        child: const WelcomeScreen(),
      ),
    );
  }
}
