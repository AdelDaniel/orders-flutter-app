import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_flutter_app/blocs/order_bloc/order_bloc.dart';
import 'package:orders_flutter_app/ui/graph_page/widgets/graph_widget.dart';

class GraphPage extends StatefulWidget {
  static const String routeName = 'graph';
  static const String path = "/$routeName";
  static final route = GoRoute(
    name: routeName,
    path: path,
    builder: (context, state) => const GraphPage(),
  );
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getData);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _getData(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderErrorState) {
              return Center(child: Text(state.failure.message ?? ""));
            } else if (state is GetOrdersSuccessState) {
              final data = state.ordersWrapper;
              return GraphWidget(orders: data.orders);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// Getters
  OrderBloc get _orderBloc => context.read<OrderBloc>();

  /// Helper Methods
  void _getData() => _orderBloc.add(const GetOrdersEvent());
}
