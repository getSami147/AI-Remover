import 'package:ai_object_remover/model/onbonding_Model.dart';
import 'package:ai_object_remover/res/colors.dart';
import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view/onboardingScreen/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class Onbondingscreen extends StatefulWidget {
  const Onbondingscreen({super.key});

  @override
  State<Onbondingscreen> createState() => _OnbondingscreenState();
}

class _OnbondingscreenState extends State<Onbondingscreen> {
  var select = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double imageHeight = size.height * 0.4; // Responsive height for image
    double paddingHorizontal = size.width * 0.05; // Responsive horizontal padding

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.75,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          select = value;
                        });
                      },
                      itemCount: onbondingModel.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text(
                              onbondingModel[index].upperTitle.toString(),
                              fontSize: textSizeLarge,
                              fontWeight: FontWeight.w600,
                            ).paddingTop(20), // Padding from the image set to 20
                            Expanded(
                              child: Image.asset(
                                onbondingModel[index].image.toString(),
                                height: imageHeight,
                                fit: BoxFit.fitWidth, // Responsive height for image
                              ),
                            ),
                            onbondingModel[index].title!.isNotEmpty
                                ? text(
                                    onbondingModel[index].title.toString(),
                                    maxLine: 2,
                                    fontWeight: FontWeight.w600,
                                    isCentered: true,
                                    fontSize: textSizeLarge,
                                  ).paddingTop(spacing_middle)
                                : const SizedBox(),
                            onbondingModel[index].subTitle!.isNotEmpty
                                ? text(
                                    onbondingModel[index].subTitle.toString(),
                                    fontWeight: FontWeight.w300,
                                    isLongText: true,
                                    isCentered: true,
                                    fontSize: size.width * 0.035,
                                    color: const Color.fromARGB(255, 210, 208, 208),
                                  ).paddingTop(size.height * .01)
                                : const SizedBox(),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < onbondingModel.length; i++) ...[
                        const SizedBox(width: 5),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: select == i ? primaryColor : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ]
                    ],
                  ).paddingTop(size.height * .02),
                ],
              ),
            ),
            if (select == onbondingModel.length - 1)
              elevatedButton(
                context,
                onPress: () {
                  SubscriptionScreen().launch(context);
                },
                child: text("Let’s do this", color: white),
              ).paddingTop(size.height * 0.07).paddingBottom(size.height * .02),
          ],
        ).paddingSymmetric(horizontal: paddingHorizontal),
      ),
    );
  }
}
