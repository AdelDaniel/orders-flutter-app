enum OrderStatusType { DELIVERED, ORDERED, RETURNED }

final statusValues = EnumValues({
  "DELIVERED": OrderStatusType.DELIVERED,
  "ORDERED": OrderStatusType.ORDERED,
  "RETURNED": OrderStatusType.RETURNED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
