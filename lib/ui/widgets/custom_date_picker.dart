import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/widgets/drop_down.dart';
import 'package:team_bugok_business/ui/widgets/primary_button.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class CustomDatePicker {
  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;
  final int _startYear;
  final BuildContext context;
  final ValueChanged<DateTime?> onDateSelected;
  OverlayEntry? _overlayEntry;

  CustomDatePicker({
    required this.context,
    required this.onDateSelected,
    DateTime? initialDate,
    int startYear = 2021,
  }) : _startYear = startYear {
    final date = initialDate ?? DateTime.now();
    _selectedDay = date.day;
    _selectedMonth = date.month;
    _selectedYear = date.year;
  }

  List<int> get daysInMonth {
    if (_selectedMonth == null || _selectedYear == null) return [];
    final days = DateUtils.getDaysInMonth(_selectedYear!, _selectedMonth!);
    return List<int>.generate(days, (i) => i + 1);
  }

  void _updateDate() {
    if (_selectedDay != null &&
        _selectedMonth != null &&
        _selectedYear != null) {
      final selectedDate = DateTime(
        _selectedYear!,
        _selectedMonth!,
        _selectedDay!,
      );
      onDateSelected(selectedDate);
    } else {
      onDateSelected(null);
    }
  }

  void show() {
    final theme = Provider.of<MyThemeProvider>(context, listen: false);

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final now = DateTime.now();

        final months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ];

        final years = List<String>.generate(
          now.year - _startYear + 1,
          (i) => (_startYear + i).toString(),
        ).reversed.toList();

        return GestureDetector(
          onTap: _removeOverlay,
          child: Material(
            color: Colors.black.withAlpha(170),
            child: Center(
              child: Container(
                width: 500,
                height: 380,
                decoration: BoxDecoration(
                  color: theme.surfaceDim,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.borderColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          // --- Month & Year ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDropdown(
                                height: 200,
                                selectedValue: months[_selectedMonth! - 1],
                                showDecoration: true,
                                entries: months,
                                width: 150,
                                label: "Month",
                                onSelected: (value) {
                                  final monthIndex = months.indexOf(value!) + 1;
                                  setState(() {
                                    _selectedMonth = monthIndex;
                                    if (_selectedDay! >
                                        DateUtils.getDaysInMonth(
                                          _selectedYear!,
                                          _selectedMonth!,
                                        )) {
                                      _selectedDay = 1;
                                    }
                                  });
                                },
                              ),
                              CustomDropdown(
                                height: 200,
                                showDecoration: true,
                                selectedValue: _selectedYear!.toString(),
                                entries: years,
                                width: 150,
                                label: "Year",
                                onSelected: (value) {
                                  final yearVal = int.parse(value!);
                                  setState(() {
                                    _selectedYear = yearVal;
                                    if (_selectedDay! >
                                        DateUtils.getDaysInMonth(
                                          _selectedYear!,
                                          _selectedMonth!,
                                        )) {
                                      _selectedDay = 1;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // --- Day grid ---
                          Expanded(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.center,
                              children: daysInMonth.map((day) {
                                final isSelected = day == _selectedDay;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() => _selectedDay = day);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? theme.primary
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? theme.primary
                                            : theme.borderColor,
                                      ),
                                    ),
                                    height: 45,
                                    width: 45,
                                    child: Center(
                                      child: Text(
                                        "$day",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          // --- Bottom buttons ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: const ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll(
                                    Colors.white,
                                  ),
                                ),
                                onPressed: _removeOverlay,
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(width: 10),
                              CustomButton(
                                height: 30,
                                width: 70,
                                onTap: () {
                                  _updateDate();
                                  _removeOverlay();
                                },
                                child: const Center(child: Text("OK")),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
