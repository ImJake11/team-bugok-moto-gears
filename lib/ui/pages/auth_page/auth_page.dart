import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/ui/pages/auth_page/auth_page_right_side.dart';
import 'package:team_bugok_business/ui/pages/auth_page/widgets/auth_page_left_side.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthProvider? _auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth = context.read<AuthProvider>();

    _auth!.addListener(_authListener);
  }

  void _authListener() {
    if (_auth == null) return;

    bool isLoggedIn = _auth!.isLoggedIn;
    if (isLoggedIn) {
      Future.delayed(
        Duration(seconds: 1),
        () {
          GoRouter.of(context).go('/');
        },
      );
    }
  }

  @override
  void dispose() {
    if (_auth != null) {
      _auth!.removeListener(_authListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all( 
            color: theme.primary,
          ),
          borderRadius: BorderRadius.circular(10),
          color: theme.surfaceDim,
        ),
        child: Row(
          children: [
            AuthPageLeftSide(),
            AuthPageRightSide(),
          ],
        ),
      ),
    );
  }
}
