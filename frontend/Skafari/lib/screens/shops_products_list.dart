import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:provider/provider.dart';
import 'package:skafari/notifiers/Ktor/store_notifier.dart';

import '../notifiers/api/openfoodnotifier.dart';
import '../widgets/shops_products_list_card.dart';

class shopsproductlist extends StatefulWidget {
  final String Route;
  const shopsproductlist({Key? key, required this.Route}) : super(key: key);

  @override
  State<shopsproductlist> createState() => _shopsproductlistState();
}

class _shopsproductlistState extends State<shopsproductlist> {
  List<Product?> names = [];
  late List<String> barcodes;
  void Act() async {

    var provider = context.read<StoreapiProvider>();

    var response = await provider.getProducts(widget.Route);
    print("response: ${response}");
    response?.forEach((element) async {
      barcodes.add(element.barcode);
      //names.add(await context.read<ProductsProvider>().getProduct(element.barcode));
    });

    await context.read<ProductsProvider>().getProducts(barcodes);
    print("barcodes:${barcodes.length}");
    print("names:${names.length}");
  }
  void initState() {
    super.initState();
    print("initState");
    barcodes = [];

    Act();

  }

  @override
  Widget build(BuildContext context) {
    var watcher = context.watch<ProductsProvider>();
    names = watcher.names;

    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white70,
        elevation: 3,
        centerTitle:  true,
        title: Image.asset('assets/images/skafarilogo.png',
          fit: BoxFit.fill,
          height: 80,
        ),
        // Image.asset('assets/images/img.png', fit: BoxFit.cover)
      ),
      body: watcher.names.isEmpty
          ? const Center(
          child: CircularProgressIndicator()
            )
          : AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
          children: List.generate(names.length  , (index) {
            return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                child: ScaleAnimation(

                  duration: Duration(milliseconds: 0),
                  child: FadeInAnimation(
                      child: ShopsProductsListCard(productinfo: names[index]!!)

                  ),

                ));

          }),
        ),
      ),

    );
  }
}