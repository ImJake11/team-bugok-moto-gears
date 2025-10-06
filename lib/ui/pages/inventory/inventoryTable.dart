import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class InventoryTable extends StatefulWidget {
  final List<ProductModel> products;

  const InventoryTable({super.key, required this.products});

  @override
  State<InventoryTable> createState() => _InventoryTableState();
}

class _InventoryTableState extends State<InventoryTable> {
  int _hoveredIndex = -1;

  Widget tableCell(dynamic label, int index) => MouseRegion(
    onEnter: (event) => setState(() => _hoveredIndex = index),
    onExit: (event) => setState(() => _hoveredIndex = -1),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _hoveredIndex == index
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
      ),
      height: 50,
      child: Center(
        child: Text(
          "${label}",
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final List<String> tableHeaders = [
      "ID",
      "Name",
      "Category",
      "Color",
      "Size",
      "Selling Price",
      "Cost",
      "Stock",
      "Availability",
    ];

    return Table(
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(2),
        6: FlexColumnWidth(2),
        7: FlexColumnWidth(2),
        8: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          children: tableHeaders
              .map((label) => TableHeader(label: label))
              .toList(),
        ),

        ...List.generate(
          widget.products.length,
          (index) {
            final product = widget.products[index];

            return TableRow(
              children: [
                tableCell(product.id, index),
                tableCell(product.productName, index),
                tableCell(product.category, index),
                tableCell(product.color, index),
                tableCell(product.size, index),
                tableCell(currencyFormatter(product.sellingPrice), index),
                tableCell(currencyFormatter(product.costPrice), index),
                tableCell(product.stock, index),
                tableCell(
                  product.isActive == 1 ? "Active" : "Inactive",
                  index,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class TableHeader extends StatelessWidget {
  final String label;

  const TableHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text(
          label,
        ),
      ),
    );
  }
}
