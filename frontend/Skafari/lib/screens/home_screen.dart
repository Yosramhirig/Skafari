import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

import 'package:provider/provider.dart';



import '../notifiers/api/openfoodnotifier.dart';
import '../notifiers/local/stores_list.dart';
import '../widgets/shops_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  PageController? _pageController;
  List<String> images = [
    "https://wishes.photos/wp-content/uploads/2023/03/modern-and-beautiful-ramadan-kareem-background-with-decoration-free-vector.webp",
    "https://www.ngmisr.com/wp-content/uploads/2022/03/%D8%A7%D9%81%D8%B6%D9%84-%D8%B9%D8%B1%D9%88%D8%B6-%D9%85%D9%82%D8%A7%D8%B6%D9%8A-%D8%B1%D9%85%D8%B6%D8%A7%D9%86-%D9%84%D9%84%D9%85%D9%88%D8%A7%D8%AF-%D8%A7%D9%84%D8%BA%D8%B0%D8%A7%D8%A6%D9%8A%D8%A9-%D9%81%D9%8A-%D8%A7%D9%84%D8%B3%D8%B9%D9%88%D8%AF%D9%8A%D8%A9-2022.png",
    "https://www.almowaten.net/wp-content/uploads/%D9%85%D9%88%D8%A7%D8%AF-%D8%A7%D9%84%D8%BA%D8%B0%D8%A7%D8%A6%D9%8A%D8%A9.jpg"
  ];
  int activePage = 1;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    super.initState();
    print("here");
    getProduct('3017620422003');

  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<StroesProvider>(context);
    return Scaffold(
      appBar: AppBar(
         title: Image.asset('assets/images/skafarilogo.png',
        fit: BoxFit.fill,
        height: 80,
      ),
        backgroundColor: Colors.white70,
        elevation: 3,
        centerTitle: true,

        // Image.asset('assets/images/img.png', fit: BoxFit.cover)
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: PageView.builder(
                      itemCount: images.length,
                      pageSnapping: true,
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child:ImageFade(
                            // whenever the image changes, it will be loaded, and then faded in:
                            image: NetworkImage(images[pagePosition]),

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
                        );
                      },
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(images.length, activePage)),
                  Padding(
                    padding: const EdgeInsets.only(left: 290),
                    child: Row(
                      children: [
                        Text(
                            "متاجرنا",
                            style:ArabicTextStyle(arabicFont: ArabicFont.tajawal,fontSize:27)),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(10),

                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,

                      children: List.generate(list.storeslist.length, (index) {
                        return
                          shopslist(store: list.storeslist[index],);
                      }
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
