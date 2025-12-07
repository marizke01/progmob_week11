import 'package:flutter/material.dart';
import 'services/prefs_service.dart';
import 'services/database_service.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

// CONTROLLER GLOBAL UNTUK TEMA
ValueNotifier<bool> themeNotifier = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init SharedPreferences
  await PrefsService.init();

  // Set theme dari prefs
  themeNotifier.value = PrefsService.getDarkMode();

  // Init database
  await DatabaseService().database;

  runApp(const SimpleNotesApp());
}

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Simple Notes Login",
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

          // ---- LIGHT MODE ----
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            fontFamily: 'Poppins',
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFFD2B48C)),
          ),

          // ---- DARK MODE ----
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            fontFamily: 'Poppins',
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.brown, brightness: Brightness.dark),
          ),

          initialRoute:
              PrefsService.getLoggedIn() ? '/home' : '/login',

          routes: {
            '/login': (_) => const LoginPage(),
            '/home': (_) => const HomePage(),
          },
        );
      },
    );
  }
}
