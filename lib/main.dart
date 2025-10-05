import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/global_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Bugok',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFE64A19),
          onPrimary: Colors.white,
          secondary: Color(0xFFF68B1F),
          onSecondary: Colors.black,
          tertiary: Color(0xFFFFC041),
          error: Colors.red,
          onError: Colors.red,
          surface: Color.fromARGB(255, 33, 33, 33),
          onSurface: Colors.white,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: GlobalWrapper(),
    );
  }
}
