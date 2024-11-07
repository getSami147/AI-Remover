import 'dart:io';
import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view%20model/provider_controllers/galleryController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ObjectRemoverScreen extends StatefulWidget {
  @override
  State<ObjectRemoverScreen> createState() => _ObjectRemoverScreenState();
}

class _ObjectRemoverScreenState extends State<ObjectRemoverScreen> {
  double brushSize = 40; // Default brush size
  double offset = 5;    // Default offset
  Offset brushPosition = Offset.zero; // Position of the brush
  List<Offset> selectedAreas = []; // List to store selected areas

  @override
  Widget build(BuildContext context) {
    // Get the GalleryController instance
    final GalleryController galleryController = Get.find();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // Display the selected image with the brush overlay
                Center(
                  child: Obx(() {
                    if (galleryController.selectedImagePath.isNotEmpty) {
                      return GestureDetector(
                        onPanUpdate: (details) {
                          // Update brush position on user interaction
                          setState(() {
                            brushPosition = details.localPosition;
                            selectedAreas.add(brushPosition); // Add position to selected areas
                          });
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
                            ...selectedAreas.map((position) => Positioned(
                                  left: position.dx - brushSize / 2,
                                  top: position.dy - brushSize / 2,
                                  child: Container(
                                    width: brushSize,
                                    height: brushSize,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )),
                            // Brush indicator to show the current brush position
                            if (brushPosition != Offset.zero)
                              Positioned(
                                left: brushPosition.dx - brushSize / 2,
                                top: brushPosition.dy - brushSize / 2,
                                child: Container(
                                  width: brushSize,
                                  height: brushSize,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    shape: BoxShape.circle,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(svg_leftArrow).paddingLeft(spacing_control),
                        SvgPicture.asset(svg_rightArrow).paddingLeft(spacing_standard),
                      ],
                    ),
                    SvgPicture.asset(svg_leftlinear).paddingLeft(spacing_standard),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Size", fontWeight: FontWeight.w600),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: Slider(
                                value: brushSize,
                                min: 40,
                                max: 70,
                                onChanged: (value) {
                                  setState(() {
                                    brushSize = value;
                                  });
                                },
                              ),
                            ),
                            text('${brushSize.toInt()}')
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Offset", fontWeight: FontWeight.w600),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: Slider(
                                value: offset,
                                min: 1,
                                max: 50,
                                onChanged: (value) {
                                  setState(() {
                                    offset = value;
                                  });
                                },
                              ),
                            ),
                            text('${offset.toInt()}')
                          ],
                        ),
                      ],
                    ),
                  ],
                ).paddingTop(spacing_thirty),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Color(0xff20252D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(svg_auto),
                  ),
                  text("Auto", fontSize: textSizeSmall),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Color(0xff20252D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(svg_brush),
                  ),
                  text("Remove Object", fontSize: textSizeSmall),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Color(0xff20252D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(svg_Lasso, height: 40, width: 40),
                  ),
                  text("Lasso", fontSize: textSizeSmall),
                ],
              ),
            ],
          ).paddingBottom(spacing_thirty),
        ],
      ).paddingSymmetric(horizontal: spacing_twinty),
    );
  }
}