part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitialState extends OrderState {
  const OrderInitialState();
}

class OrderLoadingState extends OrderState {
  const OrderLoadingState();
}

class OrderErrorState extends OrderState {
  final Failure failure;
  const OrderErrorState(this.failure);
}

/// Get Orders Success State
class GetOrdersSuccessState extends OrderState {
  final OrdersWrapper ordersWrapper;
  const GetOrdersSuccessState(this.ordersWrapper);

  @override
  List<Object> get props => [ordersWrapper];
}
