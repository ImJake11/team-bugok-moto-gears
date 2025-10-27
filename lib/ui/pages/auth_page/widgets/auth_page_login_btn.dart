import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

Widget authPageLoginButton() {

  bool isHovered = false;

  return StatefulBuilder(builder: (context, setState) {

    final theme = context.read<MyThemeProvider>();
    final auth = context.watch<AuthProvider>();

    bool isLoading =auth.isLoading;
    
    return  GestureDetector(
      onTap: () =>
          Provider.of<AuthProvider>(context, listen: false).checkPassword(),
      child: MouseRegion(
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: isHovered ? theme.secondary : theme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: isLoading
              ? Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Logging in'),
                    SpinKitFadingCircle(
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                )
              : Center(child: Text('Login')),
        ),
      ),
    );
  },);
}