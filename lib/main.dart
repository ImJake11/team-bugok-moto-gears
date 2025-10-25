import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/sidebar_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/router/config.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await ScreenUtil.ensureScreenSize();
  await windowManager.ensureInitialized();

  const minSize = Size(1280, 720);

  const windowOptions = WindowOptions(
    size: minSize,
    center: true,
    title: "Team Bugok Moto Gears",
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setSize(minSize);
    await windowManager.setMinimumSize(minSize);
    await windowManager.setAsFrameless();
  });

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.d
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyThemeProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => ReferencesValuesProviderCache()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => SidebarProvider(),
        ),
      ],
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductFormBloc()),
            BlocProvider(
              create: (context) => PosBloc(
                formBloc: context.read<ProductFormBloc>(),
              ),
            ),
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
              textTheme: GoogleFonts.manropeTextTheme(
                ThemeData.dark().textTheme,
              ),

              colorScheme: ColorScheme.dark(),
              useMaterial3: true,
            ),
            themeMode: ThemeMode.dark,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
