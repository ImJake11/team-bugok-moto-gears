import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  const LoadingWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        SpinKitFadingCircle(
          color: context.watch<MyThemeProvider>().primary,
          size: 50,
        ),
        Text(message ?? "Please wait..."),
      ],
    );
  }
}
