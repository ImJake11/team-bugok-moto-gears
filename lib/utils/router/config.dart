import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:team_bugok_business/ui/global_wrapper.dart';
import 'package:team_bugok_business/ui/pages/inventory/inventory.dart';
import 'package:team_bugok_business/ui/pages/inventory/new_product_form/new_product_form.dart';

final GoRouter routeConfig = GoRouter(
  initialLocation: "/inventory",
  routes: [
    ShellRoute(
      pageBuilder: (context, state, child) {
        return CustomTransitionPage(
          child: GlobalWrapper(child: child),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
      routes: [
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
          ],
        ),
      ],
    ),
  ],
);
