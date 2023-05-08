


import 'package:arabic_font/arabic_font.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

import 'package:provider/provider.dart';
import 'package:skafari/screens/shops_products_list.dart';
import '../constanats/constants.dart';
import '../models/local/stores.dart';
import '../notifiers/Ktor/store_notifier.dart';
import '../notifiers/api/openfoodnotifier.dart';
import '../notifiers/local/my_list_notifier.dart';

class DescriptionScreen extends StatefulWidget {
  final String barcode;

  const DescriptionScreen({Key? key, required this.barcode}) : super(key: key);

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
late bool faal;
late bool mamash;
late bool Jehad;
late bool Aloruba;
late List<Stores> myStoreslist = [];
void Act() async {
  faal = await context.read<StoreapiProvider>().getproductbybarcode("Faal", widget.barcode);
  mamash = await context.read<StoreapiProvider>().getproductbybarcode("Mamash", widget.barcode);
  Jehad = await context.read<StoreapiProvider>().getproductbybarcode("Jehad", widget.barcode);
  Aloruba = await context.read<StoreapiProvider>().getproductbybarcode("Aloruba", widget.barcode);
  if (faal) myStoreslist.add( Stores(
      storeTitle: 'جهاد مول',
      storeLink: 'Jehadmall',
      iconLink: 'assets/images/jehadmall.jpg'),);

  if (mamash) myStoreslist.add( Stores(
      storeTitle: 'ماماش',
      storeLink: 'Mamash',
      iconLink: 'assets/images/mamash.jpg'));

  if (Aloruba) myStoreslist.add(   Stores(
      storeTitle: 'العروبة',
      storeLink: 'Aloruba',
      iconLink: 'assets/images/aluroba.jpg'));

  if (Jehad) myStoreslist.add( Stores(
      storeTitle: 'جهاد مول',
      storeLink: 'Jehadmall',
      iconLink: 'assets/images/jehadmall.jpg'));

}
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    context.read<ProductsProvider>().getProduct(widget.barcode);
    context.read<StoreapiProvider>().getproductbybarcode("Faal", widget.barcode);
     context.read<StoreapiProvider>().getproductbybarcode("Mamash", widget.barcode);
     context.read<StoreapiProvider>().getproductbybarcode("Jehad", widget.barcode);
   context.read<StoreapiProvider>().getproductbybarcode("Aloruba", widget.barcode);
    Act();
  }

  void dispose(){
    //...
    super.dispose();
    //...
  }
  @override
  Widget build(BuildContext context) {


    var provider = context.watch<ProductsProvider>();
    var response = provider.data;
    bool unhalal = false;
    response?.ingredientsText?.split(", ").forEach((word){
      if (word == "beef" || word == "gelatin" || word == "alcohol" || word == "Gelatin" ){
        unhalal = true;
      }
    });
    ProductsListProvider Listprovider = context.read<ProductsListProvider>();
    return Scaffold(

        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Image.asset('assets/images/skafarilogo.png',
              fit: BoxFit.fill,
              height: 80,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                dispose();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.orange, // add custom icons also
              ),
            ),
            backgroundColor: Colors.white70,
            elevation: 3,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Listprovider.insertToDatabase(response?.barcode ?? "null", response?.productName ?? "null", response?.imageFrontUrl ?? "null" );
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
                icon: Icon(
                  Icons.add_circle_outlined,
                  color: AppColors.orange,
                ),
              ),
            ] // Image.asset('assets/images/img.png', fit: BoxFit.cover)
            ),
        body: response == null
            ? const Center(child: CircularProgressIndicator())
            :
        Container(

          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/desbg.jpg",
                ),
                fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Container(

                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),

                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),


                  )),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 100),
                child: Container(
                  decoration: BoxDecoration(


                    borderRadius: BorderRadius.circular(70.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    child: Container(

                      height: 200,
                      width: 200,
                      child: ImageFade(
                        // whenever the image changes, it will be loaded, and then faded in:
                        image: NetworkImage(response?.imageFrontUrl ?? "null" ),

                        // slow fade for newly loaded images:
                        duration: const Duration(milliseconds: 700),

                        // if the image is loaded synchronously (ex. from memory), fade in faster:
                        syncDuration: const Duration(milliseconds: 150),

                        // supports most properties of Image:
                        alignment: Alignment.center,
                        fit: BoxFit.cover,

                        // shown behind everything:
                        placeholder: Container(
                          color: const Color(0xFFCFCDCA),
                          alignment: Alignment.center,
                          child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
                        ),

                        // shows progress while loading an image:
                        loadingBuilder: (context, progress, chunkEvent) =>
                            Center(child: CircularProgressIndicator(value: progress)),

                        // displayed when an error occurs:
                        errorBuilder: (context, error) => Container(
                          color: const Color(0xFF6F6D6A),
                          alignment: Alignment.center,
                          child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
                        ),

                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 260, right: 10, left: 10 ),
                child: Container(
                    alignment : Alignment.topCenter,
                  child: Text( response?.productName ?? "",
                      textDirection: TextDirection.rtl,
                      style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        fontSize: 24,

                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3),
                ),
              ),

              //scrollable from here
              SizedBox(height: 16),
              Padding(

                padding: const EdgeInsets.only(top:320.0),
                child: SingleChildScrollView(

                  scrollDirection: Axis.vertical,
                  child: Column(

                    children: [

      Padding(
          padding: const EdgeInsets.only(top: 20, right: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("المكونات",
                    style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ])),
      Container(

        padding: const EdgeInsets.only(top: 10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(

                decoration: BoxDecoration(


                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(right:20,top:20,bottom:20),
                child: Text(
                  response?.ingredientsText ?? "لا تتوفر معلومات عن هذا المنتج"
                  ,  textDirection: TextDirection.rtl, style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  fontSize: 18,
                ),)),
          ),
          unhalal
              ? Padding(padding:  EdgeInsets.only(top: 10),
          child: Text("!! قد يحتوي هذا المنتج على مكون غير حلال",
              style: ArabicTextStyle(
                arabicFont: ArabicFont.tajawal,
                fontSize: 18,
                color: Colors.red
              )),
          )
              :Container(height:0),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text("الشركة المصنعة",
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.tajawal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.only(right:20,left:20),
            child: Container(
                decoration: BoxDecoration(


                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(right: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 20,left:20,bottom:20),
                          child: Text(response?.brands ?? "لا تتوفر معلومات عن هذا المنتج",
                              textDirection: TextDirection.rtl, style: ArabicTextStyle(
                                arabicFont: ArabicFont.tajawal,
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          

    ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:10,right: 17),
                  child: Text("متوفر في",
                      style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
             child: myStoreslist.length == 0 ? Text("لا يتوفر هذا المنتج في أي من متاجرنا") :
             GridView.builder(
               scrollDirection: Axis.vertical,
               itemCount: myStoreslist.length,
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 10,
                 crossAxisCount: 2,
                 childAspectRatio: 1.2,
               ),
               itemBuilder: (context, i) =>
                   GestureDetector(
                     onTap: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => shopsproductlist(Route: myStoreslist[i].storeLink!!)),
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
                                       Text(myStoreslist[i].storeTitle!!,style:ArabicTextStyle(arabicFont: ArabicFont.tajawal,fontSize:18)),
                                     ],
                                   ),
                                 ),
                               ),

                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
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
                                 AssetImage(myStoreslist[i].iconLink!!),
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
          ),

        ],
                  ),
                ),
              ])
                ))]
          )
          ,));
  }


}


