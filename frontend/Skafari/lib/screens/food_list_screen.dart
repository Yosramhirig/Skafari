import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:skafari/notifiers/local/my_list_notifier.dart';

import '../widgets/grocery_list_items_card.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {

  @override
  Widget build(BuildContext context) {
    ProductsListProvider watcher = context.watch<ProductsListProvider>();
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
      body: watcher.products == null
          ? const Center(
          child: Text(
            "No Items",
            style: TextStyle(fontSize: 32),
          ))
          : AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
          children: List.generate(watcher.products!.length, (index) {
            return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 2,
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 3000),
                  child: FadeInAnimation(
                      child: GroceryListItemsCard(Id: index)
                  ),
                ));
          }),
        ),
      ),

    );
  }
}