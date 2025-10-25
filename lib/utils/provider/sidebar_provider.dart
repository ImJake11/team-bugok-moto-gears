import 'package:flutter/material.dart';

class ButtonProp {
  final String name;
  final String icon;
  final String routeName;

  ButtonProp({required this.name, required this.icon, required this.routeName});
}

class SidebarProvider extends ChangeNotifier {
  final List<ButtonProp> _buttonsData = [
    ButtonProp(
      routeName: "dashboard",
      name: "Dashboard",
      icon: "assets/images/dashboard.png",
    ),
    ButtonProp(
      routeName: "inventory",
      name: "Inventory Management",
      icon: "assets/images/box.png",
    ),
    ButtonProp(
      routeName: "pos",
      name: "New Sale",
      icon: "assets/images/pos-terminal.png",
    ),
    ButtonProp(
      name: "Small Expense",
      icon: "assets/images/shopping-bag.png",
      routeName: "small-purchase",
    ),
    ButtonProp(
      name: "Sales History",
      icon: "assets/images/sales.png",
      routeName: 'sales',
    ),
    ButtonProp(
      name: "Expense Summary",
      icon: "assets/images/expenses.png",
      routeName: 'expenses',
    ),
    ButtonProp(
      name: "Store Setup",
      icon: "assets/images/settings.png",
      routeName: 'settings',
    ),
  ];

  bool _isMinimized = false;

  List<ButtonProp> get buttonsData => _buttonsData;
  bool get isMinimized => _isMinimized;

  void toggleSidebar() {
    _isMinimized = !_isMinimized;
    notifyListeners();
  }
}
