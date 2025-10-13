import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_row.dart';
import 'package:team_bugok_business/ui/widgets/date_time_display.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/utils/database/repositories/sales_repository.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  late final Future<List<SalesModel>> _sales;

  int _indexInView = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sales = SalesRepository().retrieveSales();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        spacing: 15,
        children: [
          // date and time
          DateTimeDisplay(),
          //Table Header
          Flex(
            direction: Axis.horizontal,
            children: [
              SalesPageTableHeader(
                label: "ID",
                borderRadiusGeometry: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              SalesPageTableHeader(label: "Date"),
              SalesPageTableHeader(label: "Time"),
              SalesPageTableHeader(label: "No. Items"),
              SalesPageTableHeader(label: "Total"),
              SalesPageTableHeader(
                label: "Action",
                borderRadiusGeometry: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ],
          ),

          Expanded(
            child: FutureBuilder(
              future: _sales,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingWidget(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('something went wrong'),
                  );
                }

                final sales = snapshot.data;

                return sales == null || sales.isEmpty
                    ? Center(
                        child: Text("No sales found"),
                      )
                    : ListView(
                        children: List.generate(
                          sales.length,
                          (index) {
                            return SalesPageTableRow(
                              index: index,
                              sale: sales[index],
                              isOnView: _indexInView == index,
                              onHide: () => setState(() => _indexInView = -1),
                              onView: () =>
                                  setState(() => _indexInView = index),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
