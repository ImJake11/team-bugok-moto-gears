import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/provider/auth_provider.dart';
import '../utils/provider/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthProvider _auth;

  @override
  void initState() {
    super.initState();

    _auth = context.read<AuthProvider>();

    // ✅ Attach listener first
    _auth.addListener(
      _authListener,
    );

    // ✅ Then trigger session check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _auth.checkUserSession();
    });
  }

  void _authListener() async {
    if (!mounted) return;

    final isLoggedIn = _auth.isLoggedIn;

    await Future.delayed(Duration(seconds: 2));
    if (isLoggedIn == true) {
      GoRouter.of(context).go('/');
    } else {
      GoRouter.of(context).goNamed('auth-page');
    }

    _auth.removeListener(_authListener);
  }

  @override
  void dispose() {
    _auth.removeListener(_authListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.primary,
          ),
          borderRadius: BorderRadius.circular(10),
          color: theme.surfaceDim,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: theme.primary,
                size: 50,
              ),
              const SizedBox(height: 15),
              const Text(
                "Checking User Session",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
