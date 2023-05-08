import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:provider/provider.dart';
import 'package:skafari/constanats/constants.dart';
import '../notifiers/local/my_list_notifier.dart';
import '../screens/description_screen.dart';

class ShopsProductsListCard extends StatefulWidget {
  final Product productinfo;
  const ShopsProductsListCard({Key? key, required this.productinfo}) : super(key: key);

  @override
  State<ShopsProductsListCard> createState() => _ShopsProductsListCardState();
}

class _ShopsProductsListCardState extends State<ShopsProductsListCard>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    ProductsListProvider Listprovider = context.read<ProductsListProvider>();

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DescriptionScreen(barcode: widget.productinfo.barcode!!)),
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
                      image: NetworkImage(widget.productinfo.imageFrontUrl ?? "Null"
                        ,


                      ),

                    ),

                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 3, right: 3),
                    child: Text(
                        widget.productinfo.productName ?? "Null",
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: IconButton(
                              onPressed: () {
                                Listprovider.insertToDatabase(widget.productinfo.barcode ?? "null", widget.productinfo.productName ?? "null", widget.productinfo.imageFrontUrl ?? "null" );
                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'DONE!',
                                    message:
                                    'تمت إضافة المنتج إلى قائمتك',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              },
                              icon: Icon(Icons.add),

                            ),
                          )),
                      SizedBox(width: 85),
                      Padding(

                        padding: EdgeInsets.only(top: 0),
                        child: GestureDetector(

                          onTap: () {

                          },
                          child: SizedBox(

                            height: 32,
                            width: 20,
                            child: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.orange,),

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
