import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/ui/global_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:team_bugok_business/utils/router/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductFormBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Team Bugok',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.dark().textTheme,
          ),
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
            surface: Color.fromARGB(255, 26, 26, 26),
            onSurface: Colors.white,
          ),
        ),
        themeMode: ThemeMode.dark,
        routerConfig: routeConfig,
      ),
    );
  }
}
