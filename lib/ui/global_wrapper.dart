import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/widgets/loading_overlay.dart';
import 'package:team_bugok_business/ui/widgets/sidebar.dart';
import '../utils/provider/references_values_cache_provider.dart';
import '../utils/provider/theme_provider.dart';

class GlobalWrapper extends StatefulWidget {
  final Widget child;

  const GlobalWrapper({super.key, required this.child});

  @override
  State<GlobalWrapper> createState() => _GlobalWrapperState();
}

class _GlobalWrapperState extends State<GlobalWrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () {
        context.read<ReferencesValuesProviderCache>();
        context.read<MyThemeProvider>();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.surfaceDim,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  Sidebar(),
                  Expanded(
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
          LoadingOverlay(),
        ],
      ),
    );
  }
}
