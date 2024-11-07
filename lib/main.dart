import 'package:ai_object_remover/view%20model/provider_controllers/galleryController.dart';
import 'package:ai_object_remover/view%20model/provider_controllers/removeObjectController.dart';
import 'package:ai_object_remover/view/home/homeScreen.dart';
import 'package:ai_object_remover/view/onboardingScreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:ai_object_remover/res/colors.dart';
import 'package:get/get.dart'; // Import GetX package

void main() {
 Get.lazyPut(() => GalleryController());
 Get.lazyPut(() => RemoveObjectController());
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: bgColor,
             primarySwatch: Colors.teal,
        colorScheme: const ColorScheme.light(
          primary: primaryColor, // Header background color
          onPrimary: Colors.white, // Header text color
          onSurface: Colors.black, // Body text color
        ),    
         
            useMaterial3: true,
          ),
      home:  homeScreen(),
      // SplashScreen(), // Your initial screen
    );
  }
}
