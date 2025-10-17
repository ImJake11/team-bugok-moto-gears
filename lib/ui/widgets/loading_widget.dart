import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
        Text("Please wait..."),
      ],
    );
  }
}
