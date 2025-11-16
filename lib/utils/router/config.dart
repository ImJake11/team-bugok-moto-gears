import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/ui/global_wrapper.dart';
import 'package:team_bugok_business/ui/pages/auth_page/auth_page.dart';
import 'package:team_bugok_business/ui/pages/dashboard/dashboard_page.dart';
import 'package:team_bugok_business/ui/pages/expenses/expenses_page.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventory.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form.dart';
import 'package:team_bugok_business/ui/pages/inventory/product_view/product_view.dart';
import 'package:team_bugok_business/ui/pages/pos/pos_page.dart';
import 'package:team_bugok_business/ui/pages/sales/sales_page.dart';
import 'package:team_bugok_business/ui/pages/settings/settings_page.dart';
import 'package:team_bugok_business/ui/pages/small_purchases/small_purchase.dart';
import 'package:team_bugok_business/ui/splash_screen.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

GoRouter router = GoRouter(
  initialLocation: "/splash_screen",
  routes: [
    GoRoute(
      path: "/splash_screen",
      name: 'splash-screen',
      pageBuilder: (context, state) => const MaterialPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: "/auth_page",
      name: 'auth-page',
      pageBuilder: (context, state) => const MaterialPage(
        child: AuthPage(),
      ),
    ),

    ShellRoute(
      pageBuilder: (context, state, child) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: GlobalWrapper(child: child),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // slide from right
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
      routes: [
        GoRoute(
          path: "/",
          name: "dashboard",
          pageBuilder: (context, state) =>
              const MaterialPage(child: DashboardPage()),
        ),
        GoRoute(
          path: "/expenses_page",
          name: "expenses",
          pageBuilder: (context, state) =>
              MaterialPage(child: const ExpensesPage()),
        ),
        GoRoute(
          path: "/small_purchase",
          name: "small-purchase",
          pageBuilder: (context, state) => MaterialPage(
            child: const SmallPurchase(),
          ),
        ),
        GoRoute(
          name: "inventory",
          path: "/inventory",
          pageBuilder: (context, state) => MaterialPage(
            child: const InventoryPage(),
          ),
          routes: [
            GoRoute(
              path: "product_view",
              name: "product-view",
              pageBuilder: (context, state) {
                final productModel = state.extra as ProductModel;

                return MaterialPage(
                  child: ProductView(
                    productModel: productModel,
                  ),
                );
              },
            ),
            GoRoute(
              path: "new_product_form",
              name: "new-product-form",
              pageBuilder: (context, state) {
                String? productId = state.uri.queryParameters['id'];

                return MaterialPage(
                  child: NewProductForm(
                    productId: productId != null
                        ? int.tryParse(productId)
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: "/pos_page",
          name: "pos",
          pageBuilder: (context, state) => MaterialPage(child: const PosPage()),
        ),
        GoRoute(
          path: "/sales_page",
          name: "sales",
          pageBuilder: (context, state) =>
              MaterialPage(child: const SalesPage()),
        ),
        GoRoute(
          path: "/settings_page",
          name: "settings",
          pageBuilder: (context, state) =>
              MaterialPage(child: const SettingsPage()),
        ),
      ],
    ),
  ],
);
