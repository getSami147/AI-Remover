import 'dart:ui';

import 'package:get/get.dart';

class RemoveObjectController extends GetxController {
  var brushSize = 40.0.obs; // Default brush size
  var brushPosition = Offset.zero.obs; // Position of the brush
  var selectedAreas = <Offset>[].obs; // List to store selected areas
  var undoStack = <RxList<Offset>>[].obs; // Stack for undo actions
  var redoStack = <RxList<Offset>>[].obs; // Stack for redo actions
  var selectedTool = 0.obs; // Track selected tool; 1 for "Remove Object"

  void changeBrushSize(double value) {
    brushSize.value = value;
  }

  void changeBrushOffset(double value) {
    brushPosition.value = Offset(value, brushPosition.value.dy);
  }

  void addSelectedArea(Offset position) {
    selectedAreas.add(position);
  }

  void setSelectedTool(int toolIndex) {
    selectedTool.value = toolIndex;
  }

  void undo() {
    if (undoStack.isNotEmpty) {
      redoStack.add(selectedAreas.toList().obs);
      selectedAreas.value = undoStack.removeLast();
    }
  }

  void redo() {
    if (redoStack.isNotEmpty) {
      undoStack.add(selectedAreas.toList().obs);
      selectedAreas.value = redoStack.removeLast();
    }
  }
}
