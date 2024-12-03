import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_flutter_app/ui/graph_page/pages/graph_page.dart';
import 'package:orders_flutter_app/ui/home/models/adaptive_destination_model.dart';
import 'package:orders_flutter_app/ui/home/widgets/adaptive_destination_widget.dart';
import 'package:orders_flutter_app/ui/orders_page/pages/order_page.dart';

class HomeMainScreen extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const HomeMainScreen({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffoldWidget(
      title: const Text('Ant Group'),
      currentIndex: selectedIndex,
      body: child,
      onNavigationIndexChange: (idx) {
        if (idx == 0) context.go(OrderPage.path);
        if (idx == 1) context.go(GraphPage.path);
      },
      destinations: const [
        AdaptiveDestinationModel(
          title: 'Dashboard',
          icon: Icons.dashboard,
        ),
        AdaptiveDestinationModel(
          title: 'Graph',
          icon: Icons.data_exploration,
        ),
      ],
    );
  }
}
