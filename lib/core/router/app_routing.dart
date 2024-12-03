import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_flutter_app/ui/graph_page/pages/graph_page.dart';
import 'package:orders_flutter_app/ui/home/screen/home_main_screen.dart';
import 'package:orders_flutter_app/ui/orders_page/pages/order_page.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');

class AppRouting {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: OrderPage.path,
    routes: [
      ShellRoute(
        navigatorKey: appShellNavigatorKey,
        builder: (context, state, child) {
          return HomeMainScreen(
            selectedIndex: switch (state.uri.path) {
              var p when p.startsWith(OrderPage.path) => 0,
              var p when p.startsWith(GraphPage.path) => 1,
              _ => 0,
            },
            child: child,
          );
        },
        routes: [
          OrderPage.route,
          GraphPage.route,
        ],
      ),
    ],
  );
}
