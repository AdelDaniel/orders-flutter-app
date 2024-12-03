import 'package:orders_flutter_app/data_source/order_data_source.dart';
import 'package:orders_flutter_app/res/app_values.dart';

void dataSourcesInitContainer() {
  sl.registerLazySingleton<BaseOrderLocalDataSource>(
    () => const OrderJsonFileDataSource(),
  );
}
