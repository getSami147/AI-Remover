import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/colors.dart';
import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view/onboardingScreen/onbondingscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInitial = true;
  @override
  void initState() {
 

    // provider.getCurrentCoordinates();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isInitial = false;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
    //   provider.isCheckLogin(context); // Corrected method name
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  Onbondingscreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
              alignment: Alignment.center,
              child: SvgPicture.asset(svg_copy, height:size.height * 0.08,width:size.height * 0.08 ,fit: BoxFit.contain,),
          
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
                      text("AI",fontSize: textSizeXXLarge,fontWeight: FontWeight.w600,color: primaryColor),
                      text("Brush",fontSize: textSizeXXLarge,fontWeight: FontWeight.w600),

          ],).paddingBottom(spacing_twinty)
        ],
      ),
    );
  }
}
