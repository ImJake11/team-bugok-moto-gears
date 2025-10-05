import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/inventory.dart';
import 'package:team_bugok_business/ui/widgets/sidebar.dart';

class GlobalWrapper extends StatelessWidget {
  const GlobalWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(child: InventoryPage()),
        ],
      ),
    );
  }
}
