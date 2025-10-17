import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/utils/helpers/compute_product_stock.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
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
    child: GestureDetector(
      onTap: () => GoRouter.of(
        context,
      ).replaceNamed('product-view', extra: widget.products[index]),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _hoveredIndex == index
              ? Colors.grey.shade800
              : index.isEven
              ? Theme.of(context).colorScheme.surface
              : Colors.grey.shade900,
        ),
        height: 50,
        child: Center(
          child: Text(
            "${label}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    ),
  );

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

  @override
  Widget build(BuildContext context) {
    final List<String> tableHeaders = [
      "ID",
      "Brand",
      "Model",
      "Category",
      "Cost Price",
      "Selling Price",
      "Variants",
      "Stock",
      "Create At",
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

    return Column(
      children: [
        // Fixed header (not scrollable)
        Table(
          columnWidths: columnWidths,
          children: [
            TableRow(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surfaceDim,
              ),
              children: tableHeaders
                  .map((label) => tableHeader(label))
                  .toList(),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: columnWidths,
              children: List.generate(
                widget.products.length,
                (index) {
                  final product = widget.products[index];

                  return TableRow(
                    children: [
                      tableCell(product.id, index),
                      tableCell(product.brand, index),
                      tableCell(product.model, index),
                      tableCell(product.category, index),
                      tableCell(currencyFormatter(product.costPrice), index),
                      tableCell(currencyFormatter(product.sellingPrice), index),
                      tableCell(product.variants.length, index),
                      tableCell(
                        computeProductStock(product.variants),
                        index,
                      ),
                      tableCell(
                        convertDateStringToDate(product.createdAt),
                        index,
                      ),
                    ],
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
