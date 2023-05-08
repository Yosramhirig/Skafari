
import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skafari/models/local/stores.dart';


import '../constanats/constants.dart';
import '../screens/shops_products_list.dart';



class shopslist extends StatefulWidget {
  final Stores store;
  const shopslist({Key? key, required this.store}) : super(key: key);

  @override
  State<shopslist> createState() => _shopslist();
}

class _shopslist extends State<shopslist> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        body:

        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => shopsproductlist(Route: widget.store.storeLink!!)),
            );
          },
          child: Stack(
            alignment: Alignment.topLeft,

            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: SizedBox(
                  height: 500,
                  width: 200,
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(

                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(widget.store.storeTitle!!,style:ArabicTextStyle(arabicFont: ArabicFont.tajawal,fontSize:18)),
                          ],
                        ),
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(
                            0, 3), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                      AssetImage(widget.store.iconLink!!),
                    ),
                  ),
                ),
              ),
              Container(

                child: Padding(
                    padding: const EdgeInsets.only(top: 90,left: 140),



                    child: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.orange,)


                ),
              ),
            ],
          ),
        ),






      ),
    );
  }
}