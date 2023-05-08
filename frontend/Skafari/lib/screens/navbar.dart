import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:skafari/constanats/constants.dart';
import 'package:skafari/screens/description_screen.dart';
import 'package:skafari/screens/home_screen.dart';
import 'package:skafari/screens/search_by_barcode_screen.dart';
import 'package:skafari/screens/search_by_name_screen.dart';


import '../notifiers/api/openfoodnotifier.dart';
import 'food_list_screen.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  State<navbar> createState() => _MainPageState();
}

class _MainPageState extends State<navbar> {
  int _selectedIndex = 0;
  String _scanBarcode = 'Unknown';

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FoodListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes  ;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print("please work");
    });



   Product? x = await getProduct(barcodeScanRes) ;
    if(x == null){
      if(barcodeScanRes != "-1"){
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
      }


    }else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  DescriptionScreen(barcode: _scanBarcode)),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      floatingActionButton: SpeedDial(
          activeBackgroundColor: Colors.orangeAccent,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          children: [
            SpeedDialChild(
                child: Icon(Icons.camera_alt),
                label: "التقط صورة للمنتج",
                onTap: () {
                  scanBarcodeNormal();
                }),
            SpeedDialChild(
                child: Icon(Icons.search),
                label: "البحث عن طريق الاسم",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SearchByName()),
                  );
                }),
            SpeedDialChild(
                child: new Icon(Icons.numbers),
                label: "البحث عن طريق رمز المنتج",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SearchByBarcode()),
                  );
                })
          ],
          tooltip: 'Qr code',
          child: new Icon(Icons.qr_code_2),
          elevation: 4.0,
          backgroundColor: AppColors.orange),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: AppColors.orange, size: 40),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 14,
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: 'قائمتي',
          ),
        ],
      ),
    );
  }
}
