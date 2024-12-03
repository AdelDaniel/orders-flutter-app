import 'package:flutter/material.dart';
import 'package:orders_flutter_app/data_source/data_sources_init_container.dart';
import 'package:orders_flutter_app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dataSourcesInitContainer();
  runApp(const MyApp());
}
