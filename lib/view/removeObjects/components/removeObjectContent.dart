// import 'package:ai_object_remover/res/Images.dart';
// import 'package:ai_object_remover/res/widget.dart';
// import 'package:ai_object_remover/view%20model/provider_controllers/removeObjectController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class RemoveObjectContent extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return GestureDetector(
//       onPanUpdate: (details) {
//         final localPosition = details.localPosition;
//         controller.updateBrushPosition(localPosition); // Update brush position
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
          

//           // Display highlighted selected areas in purple
//           Obx(() => Stack(
//                 children: controller.selectedAreas
//                     .map((position) => Positioned(
//                           left: position.dx - controller.brushSize.value / 2,
//                           top: position.dy - controller.brushSize.value / 2,
//                           child: Container(
//                             width: controller.brushSize.value,
//                             height: controller.brushSize.value,
//                             decoration: const BoxDecoration(
//                               color: Colors.purple,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               )),

        

//           // Slider and Arrow Controls
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               // Arrow Buttons for Undo and Redo
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap:
//                         controller.undoStack.isNotEmpty ? controller.undo : null,
//                     child: SvgPicture.asset(
//                       svg_leftArrow,
//                       color: controller.undoStack.isNotEmpty
//                           ? Colors.black
//                           : Colors.grey,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap:
//                         controller.redoStack.isNotEmpty ? controller.redo : null,
//                     child: SvgPicture.asset(
//                       svg_rightArrow,
//                       color: controller.redoStack.isNotEmpty
//                           ? Colors.black
//                           : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ).paddingSymmetric(horizontal: 16, vertical: 8),

//               // Brush Size Slider
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Obx(() => Slider(
//                         value: controller.brushSize.value,
//                         min: 30,
//                         max: 100,
//                         onChanged: (value) {
//                           controller.updateBrushSize(value);
//                         },
//                       )),
//                   Obx(() => text('${controller.brushSize.value.toInt()}')),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:ai_object_remover/res/Constant.dart';
import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view%20model/provider_controllers/removeObjectController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class RemoveObjectContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final removeObjectController = Get.find<RemoveObjectController>();
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: removeObjectController.undoStack.isNotEmpty
                      ? removeObjectController.undo
                      : null,
                  child: SvgPicture.asset(
                    svg_leftArrow,
                    color: removeObjectController.undoStack.isNotEmpty
                        ? Colors.black
                        : Colors.grey,
                  ).paddingLeft(spacing_control),
                ),
                GestureDetector(
                  onTap: removeObjectController.redoStack.isNotEmpty
                      ? removeObjectController.redo
                      : null,
                  child: SvgPicture.asset(
                    svg_rightArrow,
                    color: removeObjectController.redoStack.isNotEmpty
                        ? Colors.black
                        : Colors.grey,
                  ).paddingLeft(spacing_standard),
                ),
              
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
                        value: removeObjectController.brushSize.value,
                        min: 40,
                        max: 100,
                        onChanged: removeObjectController.changeBrushSize,
                      ),
                    ),
                    text('${removeObjectController.brushSize.value.toInt()}')
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
                        value: removeObjectController.brushPosition.value.dx,
                        min: 0,
                        max: size.width,
                        onChanged: removeObjectController.changeBrushOffset,
                      ),
                    ),
                    text('${removeObjectController.brushPosition.value.dx.toInt()}')
                  ],
                ),
              ],
            ),
          ],
        ).paddingTop(spacing_thirty),
      ],
    );
  }
}
