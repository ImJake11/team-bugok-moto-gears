import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/pages/inventory/widgets/inventory_row.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class InventoryTable extends StatefulWidget {
  final List<ProductModel> products;

  const InventoryTable({super.key, required this.products});

  @override
  State<InventoryTable> createState() => _InventoryTableState();
}

class _InventoryTableState extends State<InventoryTable> {
 
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final List<String> tableHeaders = [
      "ID",
      "Brand",
      "Model",
      "Category",
      "Cost Price",
      "Selling Price",
      "Variants",
      "Stock",
      "Status",
    ];

    final Map<int, TableColumnWidth> columnWidths = const {
      0: FlexColumnWidth(1),
      1: FlexColumnWidth(2),
      2: FlexColumnWidth(2),
      3: FlexColumnWidth(2),
      4: FlexColumnWidth(2),
      5: FlexColumnWidth(2),
      6: FlexColumnWidth(2),
      7: FlexColumnWidth(1),
      8: FlexColumnWidth(2),
    };

    Widget tableHeader(String label) {
      return SizedBox(
        height: 50,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFe0e0e0),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Column(
      spacing: 10,
      children: [
        // Fixed header (not scrollable)
        Table(
          columnWidths: columnWidths,
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              children: tableHeaders
                  .map((label) => tableHeader(label))
                  .toList(),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                widget.products.length,
                (index) {
                  final product = widget.products[index];

                  return InventoryRow(
                    productModel: product,
                    index: index,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
