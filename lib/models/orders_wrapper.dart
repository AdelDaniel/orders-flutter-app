import 'dart:convert';

import 'package:orders_flutter_app/models/order_model.dart';
import 'package:orders_flutter_app/models/order_status_type.dart';
import 'package:orders_flutter_app/res/currency_formatter.dart';

class OrdersWrapper {
  final List<OrderModel> orders;
  const OrdersWrapper({required this.orders});

  String toJson() => json.encode(toMap());
  factory OrdersWrapper.fromJson(String source) =>
      OrdersWrapper.fromMap(json.decode(source));

  List toMap() {
    return List<dynamic>.from(orders.map((x) => x.toMap()));
  }

  factory OrdersWrapper.fromMap(List<dynamic> data) {
    return OrdersWrapper(
      orders: List<OrderModel>.from(data.map((x) => OrderModel.fromMap(x))),
    );
  }

  /// total orders
  int get totalOrdersCount => orders.length;

  /// total Orders Price
  double get totalOrdersPrice {
    return orders.fold<double>(0, (double value, order) {
      return value + order.priceAsDouble;
    });
  }

  String get totalOrdersPriceString =>
      CurrencyFormatter.formatCurrency(totalOrdersPrice);

  /// Average Price
  double get averagePrice => totalOrdersPrice / totalOrdersCount;

  String get averagePriceString =>
      CurrencyFormatter.formatCurrency(averagePrice);

  /// Total Returns
  int get totalReturns {
    return orders
        .where((order) => order.status == OrderStatusType.RETURNED)
        .length;
  }
}
