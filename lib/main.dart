import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/settings_provider.dart';
import 'package:team_bugok_business/utils/provider/sidebar_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/router/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

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
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(
          create: (_) => SidebarProvider(),
        ),
      ],
      builder: (context, child) {
        final theme = context.watch<MyThemeProvider>();

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductFormBloc()),
            BlocProvider(
              create: (context) => PosBloc(),
            ),
            BlocProvider(
              create: (context) => DashboardBloc(),
            ),
            BlocProvider(
              create: (context) => InventoryBloc(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Team Bugok',
            theme: ThemeData(
              scrollbarTheme: ScrollbarThemeData(
                thumbColor: WidgetStatePropertyAll(theme.primary),
                thickness: WidgetStatePropertyAll(4),
                radius: Radius.circular(20),
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
              colorScheme: ColorScheme.dark(
                primary: theme.primary,
              ),
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
