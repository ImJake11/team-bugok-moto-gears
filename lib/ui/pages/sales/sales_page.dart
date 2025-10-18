import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_header.dart';
import 'package:team_bugok_business/ui/pages/sales/widget/sales_page_table_row.dart';
import 'package:team_bugok_business/ui/widgets/date_picker_button.dart';
import 'package:team_bugok_business/ui/widgets/loading_widget.dart';
import 'package:team_bugok_business/utils/database/repositories/sales_repository.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<SalesModel> _sales = [];

  SalesRepository _salesRepository = SalesRepository();
  int _indexInView = -1;
  bool _isInitialized = false;
  bool _hasError = false;
  DateTime _referenceDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    try {
      setState(() => _isInitialized = false);

      final result = await _salesRepository.retrieveSales(
        isFilterInCurrentMonth: true,
        referenceDate: _referenceDate,
      );

      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _sales = result;
        _isInitialized = true;
      });
    } catch (e, st) {
      print('Failed to fetch sales ${e}');
      print(st);
      setState(() => _hasError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      child: Column(
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DatePickerButton(
                pickedDate: _referenceDate,
                onPicked: (pickedDate) {
                  setState(() => _referenceDate = pickedDate);
                  _fetchProduct();
                },
              ),
            ],
          ),
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
            child: Builder(
              builder: (context) {
                if (!_isInitialized) {
                  return Center(
                    child: LoadingWidget(),
                  );
                }

                if (_hasError) {
                  return Center(
                    child: Text('something went wrong'),
                  );
                }

                return _sales.isEmpty
                    ? Center(
                        child: Text("No sales found"),
                      )
                    : ListView(
                        children: List.generate(
                          _sales.length,
                          (index) {
                            return SalesPageTableRow(
                              index: index,
                              sale: _sales[index],
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
