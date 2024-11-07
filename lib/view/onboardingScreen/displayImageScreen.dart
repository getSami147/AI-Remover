import 'dart:io';

import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../view model/provider_controllers/galleryController.dart';

class DisplayImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the GalleryController instance
    final GalleryController galleryController = Get.find();

    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Obx(() {
              // Check if the selected image path is not empty
              if (galleryController.selectedImagePath.isNotEmpty) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.file(
                    File(galleryController.selectedImagePath.value),
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return text('No image selected');
              }
            }),
          ),
          elevatedButton(
              context,
              onPress: () {
                homeScreen().launch(context);
              },
              child: text("Start Creating", color: white),
            ).paddingBottom(spacing_twinty),
        ],
      ).paddingSymmetric(horizontal: spacing_twinty),
    );
  }
}
