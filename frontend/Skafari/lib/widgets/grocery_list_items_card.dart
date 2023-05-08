import 'package:checkmark/checkmark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../notifiers/local/my_list_notifier.dart';
import '../screens/description_screen.dart';

class GroceryListItemsCard extends StatefulWidget {
  final int Id;
  const GroceryListItemsCard({Key? key, required this.Id}) : super(key: key);

  @override
  State<GroceryListItemsCard> createState() => _GroceryListItemsCardState();
}

class _GroceryListItemsCardState extends State<GroceryListItemsCard>
    with SingleTickerProviderStateMixin {
  late int checked  ;
  late bool boolchecked;

  @override
  Widget build(BuildContext context) {
    ProductsListProvider watcher = context.watch<ProductsListProvider>();
    ProductsListProvider provider = context.read<ProductsListProvider>();
    checked = watcher.products?[widget.Id]['done'];
    setState(() {
      if(checked == 0){
        boolchecked = false;
      }else{
        boolchecked = true;
      }
    });

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DescriptionScreen(barcode: watcher.products?[widget.Id]['barcode'])),
        );
      },
      child: Container(

        child: Center(

            child: Container(
              height: 245,
              width: 170.0,

              decoration: BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin:  EdgeInsets.only(
                      top: 10.0,
                    ),
                    height: 150,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image:  DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(watcher.products?[widget.Id]['Image']
                          ,


                        ),

                      ),

                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, left: 3, right: 3),
                      child: Text(
                        watcher.products?[widget.Id]['productname'],
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        maxLines: 1,
                          overflow: TextOverflow.ellipsis
                      ),

                    ),
                  ),
                  Row(
                      children: [
                    Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            provider.deleteproduct(watcher.products?[widget.Id]['id'],);
                            setState(() {
                            });
                          },
                          icon: Icon(Icons.delete),

                        )),
                    SizedBox(width: 85),
                    Padding(

                      padding: EdgeInsets.only(top: 0),
                      child: GestureDetector(

                        onTap: () {
                          checked == 1 ? checked= 0: checked = 1;
                          provider.updatetodatabase(watcher.products?[widget.Id]['id'], checked);
                          checked == 0 ? boolchecked = true : false;
                          print(watcher.products?[widget.Id]['done']);
                          setState(() {

                          });
                        },
                        child: SizedBox(

                          height: 20,
                          width: 20,
                          child: CheckMark(
                            active: boolchecked,
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 500),
                          ),
                        ),
                      ),
                    )
                  ])
                ],

            ),
          ),
        ),
      ),
    );
  }
}
