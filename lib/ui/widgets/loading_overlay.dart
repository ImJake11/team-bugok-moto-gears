import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingProvider = context.watch<LoadingProvider>();
    final theme = context.watch<MyThemeProvider>();

    bool isShow = loadingProvider.isLoading;
    String message = loadingProvider.message;

    if (!isShow) return SizedBox();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme.surfaceDim.withAlpha(220),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: theme.surfaceDim,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: theme.primary,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              SpinKitFadingCircle(
                color: theme.primary,
                size: 50,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
