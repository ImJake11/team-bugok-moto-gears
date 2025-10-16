import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/ui/global_wrapper.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page.dart';
import 'package:team_bugok_business/ui/pages/expenses/expenses_page.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventory.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/product_view.dart';
import 'package:team_bugok_business/ui/pages/pos/pos_page.dart';
import 'package:team_bugok_business/ui/pages/sales/sales_page.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

final GoRouter routeConfig = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      pageBuilder: (context, state, child) {
        return MaterialPage(
          child: GlobalWrapper(
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: "/",
          name: "dashboard",
          builder: (context, state) => DashboardPage(),
        ),
        GoRoute(
          path: "/expenses_page",
          name: "expenses",
          builder: (context, state) => ExpensesPage(),
        ),
        GoRoute(
          name: "inventory",
          path: "/inventory",
          builder: (context, state) => InventoryPage(),
          routes: [
            GoRoute(
              path: "new_product_form",
              name: "new-product-form",
              builder: (context, state) => NewProductForm(),
            ),
            GoRoute(
              path: "product_view",
              name: "product-view",
              builder: (context, state) {
                final productModel = state.extra as ProductModel;

                return ProductView(
                  productModel: productModel,
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: "/pos_page",
          name: "pos",
          builder: (context, state) => PosPage(),
        ),
        GoRoute(
          path: "/sales_page",
          name: "sales",
          builder: (context, state) => SalesPage(),
        ),
        GoRoute(
          path: "/settings_page",
          name: "settings",
          builder: (context, state) => SettingsPage(),
        ),
      ],
    ),
  ],
);
