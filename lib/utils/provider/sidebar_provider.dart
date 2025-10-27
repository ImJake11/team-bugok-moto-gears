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
      name: "Add Product",
      icon: "assets/images/helmet.png",
      routeName: 'new-product-form',
    ),
    ButtonProp(
      routeName: "dashboard",
      name: "Dashboard",
      icon: "assets/images/dashboard.png",
    ),
    ButtonProp(
      routeName: "inventory",
      name: "Inventory",
      icon: "assets/images/box.png",
    ),
    ButtonProp(
      routeName: "pos",
      name: "Create Sale",
      icon: "assets/images/pos-terminal.png",
    ),
    ButtonProp(
      name: "Add Expense",
      icon: "assets/images/shopping-bag.png",
      routeName: "small-purchase",
    ),
    ButtonProp(
      name: "Sales",
      icon: "assets/images/sales.png",
      routeName: 'sales',
    ),
    ButtonProp(
      name: "Expenses",
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
