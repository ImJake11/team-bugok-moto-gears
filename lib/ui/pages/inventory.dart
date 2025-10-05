import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/inventory_action_button.dart';
import 'package:team_bugok_business/ui/widgets/new_product_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    var appbar = Row(
      spacing: 10,
      children: [
        CustomTextfield(),
        Expanded(child: SizedBox()),
        InventoryActionButtons(label: "Filter", icon: LucideIcons.listFilter),
        InventoryActionButtons(
          label: "Sort",
          icon: LucideIcons.chartBarIncreasing,
        ),
        NewProductButton(),
      ],
    );

    var body = Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [Text("Your inventory is empty"), NewProductButton()],
        ),
      ),
    );

    return Column(
      children: [
        CustomAppbar(child: appbar),
        body,
      ],
    );
  }
}
