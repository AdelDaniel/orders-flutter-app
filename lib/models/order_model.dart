import 'package:orders_flutter_app/models/order_status_type.dart';
import 'package:orders_flutter_app/res/currency_formatter.dart';

class OrderModel {
  final String id;
  final bool isActive;
  final String price;
  final double priceAsDouble;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final OrderStatusType status;
  final DateTime registered;

  OrderModel({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  }) : priceAsDouble = CurrencyFormatter.fromFormattedPrice(price);

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        isActive: json["isActive"],
        price: json["price"],
        company: json["company"],
        picture: json["picture"],
        buyer: json["buyer"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        status: statusValues.map[json["status"]]!,
        registered: DateTime.parse(json["registered"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "isActive": isActive,
        "price": price,
        "company": company,
        "picture": picture,
        "buyer": buyer,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "status": statusValues.reverse[status],
        "registered": registered,
      };
}
