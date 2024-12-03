import 'package:orders_flutter_app/blocs/order_bloc/order_bloc.dart';
import 'package:orders_flutter_app/core/errors/failures/failures.dart';
import 'package:orders_flutter_app/data_source/order_data_source.dart';

abstract class BaseOrderRepository {
  const BaseOrderRepository();
  Future<OrderState> getOrder();
}

class OrderRepository implements BaseOrderRepository {
  final BaseOrderLocalDataSource orderDataSource;
  const OrderRepository({required this.orderDataSource});

  @override
  Future<OrderState> getOrder() async {
    late OrderState orderState;

    await orderDataSource.getOrder(
      /// success
      (wrapper) {
        orderState = GetOrdersSuccessState(wrapper);
      },

      /// fail
      (Failure failure) {
        orderState = OrderErrorState(failure);
      },
    );

    return orderState;
  }
}
