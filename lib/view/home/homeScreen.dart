import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view%20model/provider_controllers/galleryController.dart';
import 'package:ai_object_remover/view/home/editingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../onboardingScreen/displayImageScreen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  var select = 0;

  @override
  Widget build(BuildContext context) {
    List<String> imageslist = [
      homeImage,
      homeImage2,
      homeImage3,
      homeImage4,
    ];
    var size = MediaQuery.of(context).size;
    double imageHeight = size.height * 0.3; // Responsive height for image
    double paddingHorizontal =
        size.width * 0.05; // Responsive horizontal padding

    return Scaffold(
      appBar: const CustomAppBar(
        leading: Icon(Icons.menu, color: white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                text("Let’s Create",
                    fontSize: textSizeXXLarge,
                    fontWeight: FontWeight.w600,
                    color: white),
                SvgPicture.asset(
                  svg_stars,
                  height: size.height * .027,
                ).paddingLeft(spacing_control),
              ],
            ),
            Image.asset(
              imagehomeBanner,
              height: imageHeight,
              fit: BoxFit.fitWidth, // Responsive height for image
            ).paddingTop(spacing_middle),
            Row(
              children: [
                text("History",
                    fontSize: textSizeNormal,
                    fontWeight: FontWeight.w500,
                    color: white),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ).paddingLeft(spacing_middle)
              ],
            ),
            SizedBox(
              height: size.width * 0.22,
              child: ListView.builder(
                itemCount: imageslist.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          imageslist[index],
                          height: size.width * 0.20,
                          width: size.width * 0.20,
                          fit: BoxFit.cover,
                        )),
                  );
                },
              ).paddingTop(spacing_middle),
            ),
            elevatedButton(
              context,
              onPress: () {
                _showModelBottomSheet(context);

              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ).paddingLeft(spacing_middle),
              text("Upload Image", color: white).paddingLeft(spacing_control),

              ],)
            ).paddingSymmetric().paddingTop(size.height * .08),
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
                    Get.to(() => ObjectRemoverScreen());
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
