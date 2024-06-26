import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fire/firebase_options.dart';
import 'package:todo_fire/providers/theme_provider.dart';
import 'package:todo_fire/screens/auth_screens.dart';
import 'package:todo_fire/screens/home_screen.dart';
import 'package:todo_fire/screens/main_page.dart';
import 'package:todo_fire/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: "Splash",
            routes: {
              "Main": (BuildContext context) => const MainPage(),
              "Home": (BuildContext context) => const HomeScreen(),
              "Splash": (BuildContext context) => const SplashScreen(),
              "Auth": (BuildContext context) => const AuthScreens(),
            },
            theme: ThemeData(colorScheme: provider.colorScheme),
          );
        },
      ),
    );
  }
}
