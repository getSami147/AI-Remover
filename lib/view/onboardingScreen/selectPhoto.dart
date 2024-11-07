import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view/onboardingScreen/displayImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../view model/provider_controllers/galleryController.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  State<SelectPhotoScreen> createState() => _SelectPhotoScreenState();
}

class _SelectPhotoScreenState extends State<SelectPhotoScreen> {
  var select = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double imageHeight = size.height * 0.4; // Responsive height for image
    double paddingHorizontal =
        size.width * 0.05; // Responsive horizontal padding

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                imageOnboarding,
                height: imageHeight,
                fit: BoxFit.fitWidth, // Responsive height for image
              ),
            ),
            elevatedButton(
              context,
              onPress: () {
                _showModelBottomSheet(context);
              },
              child: text("Select Photo", color: white),
            ).paddingSymmetric().paddingBottom(size.height * .02),
          ],
        ).paddingSymmetric(horizontal: paddingHorizontal),
      ),
    );
  }
}

_showModelBottomSheet(BuildContext context) {
  var size = MediaQuery.of(context).size;
  final GalleryController galleryController =
      Get.find(); // Access the controller

  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) {
      return SizedBox(
        height: size.height * .14, // Set a fixed height to prevent scrolling
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Gallery Option
            InkWell(
              onTap: () async {
                await galleryController.pickImageFromGallery();

                if (galleryController.selectedImagePath.value.isNotEmpty) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context); // Close the bottom sheet
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Get.to(() => DisplayImageScreen());
                  });
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    imagegallery, // Replace with your gallery image path
                    height: size.height * .064,
                    width: size.height * .064,
                  ),
                  text("Gallery", color: black, fontSize: textSizeSMedium)
                      .paddingTop(spacing_standard),
                ],
              ),
            ),

            // More Option
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  svg_moreVert, // Replace with your SVG asset path
                  height: size.height * .064,
                  width: size.height * .064,
                ),
                text("More", color: black, fontSize: textSizeSMedium)
                    .paddingTop(spacing_standard),
              ],
            ).paddingLeft(spacing_standard_new),
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      );
    },
  );
}
