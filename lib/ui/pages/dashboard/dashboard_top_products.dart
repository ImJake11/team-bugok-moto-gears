import 'package:flutter/material.dart';

class DashboardTopProducts extends StatelessWidget {
  const DashboardTopProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: List.generate(
              10,
              (index) => _WidgetTile(),
            ),
          ),
        ),
      ),
    );
  }
}

class _WidgetTile extends StatelessWidget {
  const _WidgetTile();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Text(
            'Brand Model',
            style: TextStyle(
              color: Colors.grey.shade500,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        Text(
          '20',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(
          width: 70,
          height: 7,
          child: LinearProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
            value: 50 / 100,
          ),
        ),
      ],
    );
  }
}
