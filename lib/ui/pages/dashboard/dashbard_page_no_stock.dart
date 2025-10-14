import 'package:flutter/material.dart';

class DashbardPageNoStock extends StatelessWidget {
  const DashbardPageNoStock({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: List.generate(
              10,
              (index) {
                return Row(
                  children: [
                    Text(
                      "Brand Model",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(20),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          "Restock",
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
