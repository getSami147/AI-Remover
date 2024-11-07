import 'package:ai_object_remover/res/Images.dart';

class OnbondingModel {
  String? upperTitle,image,title, subTitle, text2;
  bool?isButton;
  OnbondingModel({this.upperTitle, this.image, this.title, this.subTitle,this.isButton});
}

final onbondingModel = [
  OnbondingModel(
      upperTitle: "",
      image: imageOnboarding,
      title: "Remove Replace \nRefresh",
      subTitle: "It's that simple! Edit your photos injust three steps with our user-friendly app.",
      isButton: false
      ),
      OnbondingModel(
      upperTitle: "Remove Replace Refresh",
      image: imageOnboarding2,
      title: "",
      subTitle: "",
      isButton: false

      ),
       OnbondingModel(
      upperTitle: "",
      image: imageOnboarding3,
      title: "Remove Replace \nRefresh",
      subTitle: "It's that simple! Edit your photos injust three steps with our user-friendly app.",
      isButton: true
      ),  
 
];