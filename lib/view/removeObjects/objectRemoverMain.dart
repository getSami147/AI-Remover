import 'dart:io';

import 'package:ai_object_remover/res/Constant.dart';
import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/colors.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view%20model/provider_controllers/galleryController.dart';
import 'package:ai_object_remover/view%20model/provider_controllers/removeObjectController.dart';
import 'package:ai_object_remover/view/removeObjects/components/autoContent.dart';
import 'package:ai_object_remover/view/removeObjects/components/lassoContent.dart';
import 'package:ai_object_remover/view/removeObjects/components/removeObjectContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ObjectRemoverMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final galleryController = Get.find<GalleryController>();
    final objectRemoverController = Get.find<RemoveObjectController>();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Obx(() {
                    if (galleryController.selectedImagePath.isNotEmpty) {
                      return GestureDetector(
                        onPanUpdate: (details) {
                          if (objectRemoverController.selectedTool.value == 1) {
                            // Only allow drawing if "Remove Object" is selected
                            objectRemoverController.addSelectedArea(details.localPosition);
                            objectRemoverController.brushPosition.value = details.localPosition;
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                File(galleryController.selectedImagePath.value),
                                height: size.height * .4,
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Display highlighted selected areas in purple
                            ...objectRemoverController.selectedAreas.map((position) => Positioned(
                                  left: position.dx - objectRemoverController.brushSize.value / 2,
                                  top: position.dy - objectRemoverController.brushSize.value / 2,
                                  child: Container(
                                    width: objectRemoverController.brushSize.value,
                                    height: objectRemoverController.brushSize.value,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(.1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )),
                            // Brush indicator with outline only if "Remove Object" is active
                            if (objectRemoverController.selectedTool.value == 1 &&
                                objectRemoverController.brushPosition.value != Offset.zero)
                              Positioned(
                                left: objectRemoverController.brushPosition.value.dx -
                                    objectRemoverController.brushSize.value / 2,
                                top: objectRemoverController.brushPosition.value.dy -
                                    objectRemoverController.brushSize.value / 2,
                                child: Container(
                                  width: objectRemoverController.brushSize.value,
                                  height: objectRemoverController.brushSize.value,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    } else {
                      return text('No image selected');
                    }
                  }),
                ).paddingTop(spacing_standard_new),
                SizedBox(height: size.height * .13),
                Obx(() => 
                _buildDynamicContent(objectRemoverController),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => _buildIcon(index, objectRemoverController),
            ),
          ).paddingBottom(spacing_twinty),
        ],
      ).paddingSymmetric(horizontal: spacing_twinty),
    );
  }

  // Widget to build icons with dynamic selection
  Widget _buildIcon(int index, RemoveObjectController controller) {
    // Define icon assets for each index
    final iconAssets = [svg_auto, svg_brush, svg_Lasso];
    final titles = ["Auto", "Remove Object", "Lasso"];
    bool isSelected = controller.selectedTool.value == index;

    return GestureDetector(
      onTap: () {
        controller.setSelectedTool(index); // Update selected tool
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xff20252D),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              iconAssets[index],
              height: 40,
              width: 40,
              color: isSelected ? primaryColor : Colors.white,
            ),
          ),
          text(titles[index], fontSize: textSizeSmall, color: isSelected ? primaryColor : Colors.white)
              .paddingTop(spacing_control),
        ],
      ),
    );
  }

  // Build dynamic content based on the selected tool
  Widget _buildDynamicContent(RemoveObjectController controller) {
    switch (controller.selectedTool.value) {
      case 0:
        return AutoContent();
      case 1:
        return RemoveObjectContent(); // "Remove Object" content
      case 2:
        return LassoContent();
      default:
        return Container();
    }
  }
}
