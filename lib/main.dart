import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_tickets_task/provider/movie_provider.dart';
import 'package:movies_tickets_task/provider/seats_provider.dart';
import 'package:movies_tickets_task/routes/navigation_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        // home: WelcomeScreen(),
        initialRoute: Routes.welcomePage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
