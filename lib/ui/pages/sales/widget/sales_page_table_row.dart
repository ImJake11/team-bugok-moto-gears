import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_sales_items.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';
import 'package:team_bugok_business/utils/services/extract_time.dart';

class SalesPageTableRow extends StatefulWidget {
  final SalesModel sale;
  final void Function() onView;
  final void Function() onHide;
  final bool isOnView;
  final int index;

  const SalesPageTableRow({
    super.key,

    required this.sale,
    required this.onView,
    required this.onHide,
    required this.isOnView,
    required this.index,
  });

  @override
  State<SalesPageTableRow> createState() => _SalesPageTableRowState();
}

class _SalesPageTableRowState extends State<SalesPageTableRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    final viewBtn = Flexible(
      child: GestureDetector(
        onTap: () => widget.isOnView ? widget.onHide() : widget.onView(),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                widget.isOnView ? "Close" : "Show Items",
                style: TextStyle(
                  color: theme.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) {
        setState(() => _isHovered = false);
        widget.onHide();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isOnView
              ? Colors.black
              : widget.index.isEven
              ? theme.surfaceDim
              : Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 17,
          ),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  _cell(widget.sale.id),
                  _cell(convertDateStringToDate(DateTime.now())),
                  _cell(extractTime(DateTime.now())),
                  _cell(widget.sale.items?.length ?? 0),
                  _cell(currencyFormatter(widget.sale.total)),
                  viewBtn,
                ],
              ),
              if (widget.isOnView)
                SalesPageSalesItems(items: widget.sale.items),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cell(dynamic content) => Flexible(
  child: Center(
    child: Text("${content}"),
  ),
);
