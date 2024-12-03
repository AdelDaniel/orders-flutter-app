import 'package:flutter/services.dart';
import 'package:orders_flutter_app/core/errors/failures/failures.dart';
import 'package:orders_flutter_app/models/orders_wrapper.dart';
import 'package:orders_flutter_app/res/app_assets_paths.dart';

abstract class BaseOrderLocalDataSource {
  const BaseOrderLocalDataSource();

  Future<void> getOrder(
    void Function(OrdersWrapper) success,
    void Function(Failure) fail,
  );
}

class OrderJsonFileDataSource implements BaseOrderLocalDataSource {
  const OrderJsonFileDataSource();

  @override
  Future<void> getOrder(
    void Function(OrdersWrapper) success,
    void Function(Failure) fail,
  ) async {
    try {
      final response = await rootBundle.loadString(AppAssetsPaths.ordersFile);
      final OrdersWrapper wrapper = OrdersWrapper.fromJson(response);
      success(wrapper);
    } catch (onError) {
      fail(const Failure(message: "Something went wrong!"));
    }
  }
}
