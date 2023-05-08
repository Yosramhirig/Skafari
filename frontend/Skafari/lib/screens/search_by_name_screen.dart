
import 'package:arabic_font/arabic_font.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skafari/constanats/constants.dart';
import 'package:skafari/notifiers/api/openfoodnotifier.dart';
import 'package:skafari/screens/description_screen.dart';

class SearchByName extends StatefulWidget {
  const SearchByName({Key? key}) : super(key: key);

  @override
  State<SearchByName> createState() => _SearchByNameState();

}

class _SearchByNameState extends State<SearchByName> {

  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    void _onLoading() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return
                 Center(
                   child: CircularProgressIndicator(
          ),
                 )

          ;
        },
      );

    }
    void Act(String term) async{
      String barcode;
      try{

         barcode = await SearchProductByName(term);
      }catch(e){
        barcode = "Null";
      }
      print(barcode);
      if(barcode == "Null"){
        Navigator.of(context, rootNavigator: true).pop();
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
            'لا تتوفر أي معلومات عن هذا المنتج حاليا :(',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }else{
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DescriptionScreen(barcode: barcode)),
        );
      }
    }

    return  Scaffold(
      resizeToAvoidBottomInset: false,
        body: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drawing Paths',
        home: Stack(
          alignment: Alignment.center,
      children: [
        Container(
          color: Colors.white,
          child: CustomPaint(
            size: Size.infinite, //2
            painter: CurvePainter(), //3
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top:100),
          child: Container(
            alignment: Alignment.bottomCenter,
              height: 500,
              width: 350,
              //padding:  EdgeInsets.only(top: 400),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/searchimage.png"),
              ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // shadow direction: bottom right
                  )
                ],
              ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top : 400),
                  child: Center(child: Text("ادخل اسم المنتج الذي تبحث عنه", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black,decoration: TextDecoration.none, fontFamily: ArabicFont.tajawal,))
                  ),
                )],
            ),
          ),
        ),



        Padding(
          padding: const EdgeInsets.all(80),
          child: Container(
            alignment: Alignment.topCenter,

              child: CupertinoSearchTextField(
                autofocus:true,
                itemColor: AppColors.orange,
                style: TextStyle(color: AppColors.orange) ,
                placeholderStyle: TextStyle(color: AppColors.orange) ,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // shadow direction: bottom right
                    )
                  ],
                ),
                controller: SearchController,
                onSubmitted: (SearchController) {
                  _onLoading();
                  Act(SearchController);

                    },
              ),

          ),
        ),

      ],
      ),

        ),

    );
  }


}


class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.orange.withOpacity(0.7);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2 + 100, size.width, size.height * 0.25 );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
