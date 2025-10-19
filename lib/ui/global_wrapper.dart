import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/widgets/loading_overlay.dart';
import 'package:team_bugok_business/ui/widgets/sidebar.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Row(
            children: [
              Sidebar(),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
          LoadingOverlay(),
        ],
      ),
    );
  }
}
