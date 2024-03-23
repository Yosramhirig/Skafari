# Skafari
Skafari is a Flutter mobile application that uses a phone scanner to look up information on a product from the OpenFoodFact API. The app displays the product's ingredients, brand name, and whether the product is halal or not. Additionally, Skafari connects to a Kator server with different stores and shows if the product is available in these stores. It also offers the ability to add any product the user is planning to purchase to their grocery list and they can check it off or delete it once they've completed their purchase.
## Features
* Scan a product barcode to get its information.
* Display product ingredients, brand name, and halal status.
* Connect to a Kator server with different stores and show product availability.
* User-friendly interface.

## Requirements
  *  Flutter 3.7.7 or higher.
  *  Android SDK 29 or higher.
  *  iOS 9.0 or higher.
 
## Screenshots
Splash Screen            |  Home Screen            |  Search Methods             |  Grocery List 
:-------------------------:|:-------------------------:|:-------------------------: |:-------------------------:
![splashscreen](https://github.com/Yosramhirig/Skafari/assets/60020376/c5abacf7-38f0-41cd-b625-fa13bc051436)  |  ![homescreen](https://github.com/Yosramhirig/Skafari/assets/60020376/1d9f9f10-dfd0-48eb-a903-c045d4559cba)  | ![Search](https://github.com/Yosramhirig/Skafari/assets/60020376/d4d74c3f-95b3-4686-934f-8cdf02961b25) | ![grocerylist](https://github.com/Yosramhirig/Skafari/assets/60020376/26559de5-0ea8-49d8-a4d8-a64c96388417)







## Installation
  1. Clone this repository.
  2. Open the Frontend file.
  3. Run flutter pub get  to install the dependencies.
  4. Connect your device or emulator.
  5. Run flutter.
  
  * Before installing the Ktor server, make sure you have the following prerequisites installed:
    * JDK 8 or higher.
    * Gradle 5.0 or higher.
    
  * To download the Ktor server code:
    * open the backend file from this repository.
    * To build the server, use the following Gradle command:
     ./gradlew build
    * To run the server locally, use the following command:
     ./gradlew run
    * To deploy the server to a production environment, modify the configuration files as necessary and use a tool such as Docker to package the server for deployment.

## Usage
    1. Open the Skafari app.
    2. Scan a product barcode, or search it by name.
    3. View the product information, including ingredients, brand name, and halal status.
    4. Check product availability at different stores on the Kator server.
    5. Add items to your grocery list.
    
## Packages
* [Provider](https://pub.dev/packages/provide)
* [Google Fonts](https://pub.dev/packages/google_fonts)
* [OpenFoodFact API](https://pub.dev/packages/openfoodfacts)
* [Flutter_Speed_Dial](https://pub.dev/packages/flutter_speed_dial)
* [Flutter Staggered Animations](https://pub.dev/packages/flutter_staggered_animations)
* [Checkmark](https://pub.dev/packages/checkmark)
* [Connectivity Plus](https://pub.dev/packages/connectivity_plus)
* [Flutter Barcode Scanner](https://pub.dev/packages/flutter_barcode_scanner)
* [Arabic Font](https://pub.dev/packages/arabic_font)
* [Sqflite](https://pub.dev/packages/sqflite)
* [Dio](https://pub.dev/packages/dio)
* [Awesome Snackbar Content](https://pub.dev/packages/awesome_snackbar_content)
* [Image Fade](https://pub.dev/packages/image_fade)
* [Animated Pie Chart](https://pub.dev/packages/animated_pie_chart)
* [Flutter Native Splash](https://pub.dev/packages/flutter_native_splash)
* [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
