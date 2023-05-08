import 'package:flutter/cupertino.dart';

import '../../models/local/stores.dart';




class StroesProvider with ChangeNotifier {
  List<Stores> storeslist = [
    Stores(
        storeTitle: 'جهاد مول',
        storeLink: 'Jehadmall',
        iconLink: 'assets/images/jehadmall.jpg'),
    Stores(
        storeTitle: 'فال',
        storeLink: 'Faal',
        iconLink: 'assets/images/faal.jpg'),
    Stores(
        storeTitle: 'العروبة',
        storeLink: 'Aloruba',
        iconLink: 'assets/images/aluroba.jpg'),
    Stores(
        storeTitle: 'ماماش',
        storeLink: 'Mamash',
        iconLink: 'assets/images/mamash.jpg'),

  ];
}