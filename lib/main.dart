import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_tickets_task/provider/movie_provider.dart';
import 'package:movies_tickets_task/provider/seats_provider.dart';
import 'package:movies_tickets_task/routes/navigation_routes.dart';
import 'package:movies_tickets_task/user_interface/screens/login_signup/login.dart';
import 'package:movies_tickets_task/user_interface/screens/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MyApp(
          initialScreen:
              isAuthenticated ? const WelcomeScreen() : const LoginPage()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => seatsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Poppins"),
        home: initialScreen,
        // initialRoute: Routes.loginScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
