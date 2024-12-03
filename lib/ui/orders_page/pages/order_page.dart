import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orders_flutter_app/blocs/order_bloc/order_bloc.dart';
import 'package:orders_flutter_app/ui/orders_page/widgets/order_card_widget.dart';
import 'package:orders_flutter_app/res/responsive_extension.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = 'order';
  static const String path = "/$routeName";
  static final route = GoRoute(
    name: routeName,
    path: path,
    builder: (context, state) => const OrderPage(),
  );
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderErrorState) {
              return Center(child: Text(state.failure.message ?? ""));
            } else if (state is GetOrdersSuccessState) {
              final data = state.ordersWrapper;
              return GridView(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: !context.isSmallScreen ? 4 : 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                children: [
                  OrderCardWidget(
                    title: "Total Orders",
                    value: data.totalOrdersCount.toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  OrderCardWidget(
                    title: "Total Revenue",
                    value: data.totalOrdersPriceString,
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  OrderCardWidget(
                    title: "Avg. Price",
                    value: data.averagePriceString,
                    icon: Icons.price_change,
                    color: Colors.orange,
                  ),
                  OrderCardWidget(
                    title: "Total Returns",
                    value: data.totalReturns.toString(),
                    icon: Icons.undo,
                    color: Colors.red,
                  ),
                ],
              );
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
