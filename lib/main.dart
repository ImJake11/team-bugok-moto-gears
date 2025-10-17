import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/router/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  appWindow.size = Size(1280, 720);

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());

  appWindow.show();
  doWhenWindowReady(
    () {
      final win = appWindow;
      const initialize = Size(1280, 720);

      win.minSize = initialize;
      win.size = initialize;
      win.alignment = Alignment.center;
      win.title = "Team Bugok Moto Gears";
      win.show();
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyThemeProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
      ],
      builder: (context, child) {
        ScreenUtil.init(context);
        final themeProvider = context.watch<MyThemeProvider>();

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductFormBloc()),
            BlocProvider(create: (_) => PosBloc()),
            BlocProvider(
              create: (context) => DashboardBloc(
                posBloc: context.read<PosBloc>(),
                formBloc: context.read<ProductFormBloc>(),
              ),
            ),
            BlocProvider(
              create: (context) => InventoryBloc(
                formBloc: context.read<ProductFormBloc>(),
                posBloc: context.read<PosBloc>(),
              ),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Team Bugok',
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: Color.fromARGB(255, 23, 22, 22),
              colorScheme: ColorScheme(
                brightness: Brightness.dark,
                primary: themeProvider.primaryColor,
                onPrimary: Colors.white,
                secondary: themeProvider.secondaryColor,
                onSecondary: Colors.black,
                tertiary: themeProvider.tertiaryColor,
                error: Colors.red,
                onError: Colors.red,
                surface: Color(0xFF1e1e1e),
                onSurface: Colors.white,
                surfaceDim: Color(0xFF121212),
              ),
            ),
            themeMode: ThemeMode.dark,
            routerConfig: routeConfig,
          ),
        );
      },
    );
  }
}
