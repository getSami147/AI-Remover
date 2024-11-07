// import 'package:flutter/material.dart';
// import 'package:ai_object_remover/view/aboutUs/aboutMainView.dart';
// import 'package:ai_object_remover/view/aboutUs/components/experience.dart';
// import 'package:get/get.dart';

// class ProjectController  extends GetxController{
//   RxList<bool> hovers =[
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//   ].obs;


//   onHoverSlider(int index,bool value){
//     hovers[index]=value;
//   }
  
//    // Image Carousel Slider "project details"
//     var selectedIndex = 0.obs;

//   void updateSliderIndex(int index) {
//     selectedIndex.value = index;
//   }

// // about us
//  var selectedTitle = 'Experience'.obs;
//   var selectedWidget = Rx<Widget>(ExperienceWidget()); // Now it's Rx<Widget> instead of Rx<Container>

//   void updateContent(String title, Widget widget) {
//     selectedTitle.value = title;
//     selectedWidget.value = widget;
//   }

// }