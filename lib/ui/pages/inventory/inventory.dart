import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventoryTable.dart';
import 'package:team_bugok_business/ui/widgets/appbar.dart';
import 'package:team_bugok_business/ui/widgets/inventory_action_button.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/ui/widgets/text_field.dart';
import 'package:team_bugok_business/utils/databases/inventory_database.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    var newGearButton = CustomButton(
      onTap: () => GoRouter.of(context).pushNamed("new-product-form"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset(
            "assets/images/helmet.png",
            width: 20,
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
          ),
          Text(
            "New Gear",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );

    var appbar = Row(
      spacing: 10,
      children: [
        CustomTextfield(
          suffixIcon: LucideIcons.search,
        ),
        Expanded(child: SizedBox()),
        InventoryActionButtons(
          label: "Filter",
          icon: LucideIcons.listFilter,
        ),
        InventoryActionButtons(
          label: "Sort",
          icon: LucideIcons.chartBarIncreasing,
        ),
        newGearButton,
      ],
    );

    var body = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: InventoryDB().retriveAllProducts(),
          builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return InventoryTable(
                products: snapshot.data!,
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Transform(
                  transform: Matrix4.translationValues(-80, 0, 0),
                  child: Lottie.asset(
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                    "assets/animations/motor-cycle-animation.json",
                  ),
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text("Your inventory is empty"),
                  newGearButton,
                ],
              ),
            );
          },
        ),
      ),
    );

    return Column(
      spacing: 30,
      children: [
        CustomAppbar(child: appbar),
        body,
      ],
    );
  }
}
