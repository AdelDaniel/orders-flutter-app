import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_flutter_app/core/errors/failures/failures.dart';
import 'package:orders_flutter_app/models/orders_wrapper.dart';
import 'package:orders_flutter_app/repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final BaseOrderRepository orderRepository;
  OrderBloc({required this.orderRepository})
      : super(const OrderInitialState()) {
    on<GetOrdersEvent>(_onGetOrdersEvent);
  }

  FutureOr<void> _onGetOrdersEvent(
    GetOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(await orderRepository.getOrder());
  }
}
