import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skafari/notifiers/Ktor/store_notifier.dart';
import 'package:skafari/notifiers/api/openfoodnotifier.dart';
import 'package:skafari/notifiers/local/my_list_notifier.dart';
import 'package:skafari/screens/navbar.dart';

import 'notifiers/local/stores_list.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => ProductsListProvider()),
          ChangeNotifierProvider(create: (_) => StroesProvider()),
          ChangeNotifierProvider(create: (_) => StoreapiProvider())
        ],
    child : MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(textTheme: TextTheme()),
          home: navbar(),
        ),
  ));
}