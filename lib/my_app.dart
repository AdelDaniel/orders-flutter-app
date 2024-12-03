import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_flutter_app/blocs/order_bloc/order_bloc.dart';
import 'package:orders_flutter_app/core/router/app_routing.dart';
import 'package:orders_flutter_app/data_source/order_data_source.dart';
import 'package:orders_flutter_app/repositories/order_repository.dart';
import 'package:orders_flutter_app/res/app_values.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (_) => _orderBloc,
      child: MaterialApp.router(
        title: 'Ant Group Orders App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouting.router,
      ),
    );
  }

  OrderBloc get _orderBloc {
    if (!sl.isRegistered<BaseOrderRepository>()) {
      sl.registerLazySingleton<BaseOrderRepository>(
        () => OrderRepository(orderDataSource: sl<BaseOrderLocalDataSource>()),
      );
    }
    return OrderBloc(orderRepository: sl<BaseOrderRepository>());
  }
}
