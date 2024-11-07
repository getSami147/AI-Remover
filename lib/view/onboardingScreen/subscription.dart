import 'package:ai_object_remover/res/Images.dart';
import 'package:ai_object_remover/res/colors.dart';
import 'package:ai_object_remover/res/constant.dart';
import 'package:ai_object_remover/res/widget.dart';
import 'package:ai_object_remover/view/onboardingScreen/selectPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = -1;

  final List<String> features = [
    'Remove All Ads',
    'Watermarks',
    'Faster Processing',
    'Get All Premium Filters',
    'Eye-catching images AI backgrounds',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SubscriptionImageSection(),
                Column(
                  children: [
                    ...features.map((feature) => FeatureItem(feature: feature)),
                    UnlockFeaturesText(),
                    PlanSelectionRow(
                      selectedIndex: selectedIndex,
                      onSelect: (index) => setState(() => selectedIndex = index),
                      containerWidth: size.width * 0.42,
                      containerHeight: size.height * .13,
                    ),
                    GetStartedButton(),
                    GetStartedAgreement(),
                    AutoRenewInfo(),
                    const SizedBox(height: 40),
                  ],
                ).paddingSymmetric(horizontal: spacing_twinty),
              ],
            ),
          ),
          Positioned(
            top: size.height * .08,
            right: 20,
            child: InkWell(
              onTap: () {
                SelectPhotoScreen().launch(context);
              },
              child: SvgPicture.asset(svg_cross, height: 30)),
          ),
        ],
      ),
    );
  }
}

class SubscriptionImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.38,
      width: size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(imageSubscription, fit: BoxFit.contain),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String feature;

  FeatureItem({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(svg_check, height: 24),
        const SizedBox(width: spacing_standard_new),
        Flexible(
          child: text(
            feature,
            maxLine: 2,
            isLongText: true,
            fontSize: textSizeMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ).paddingTop(spacing_standard_new);
  }
}

class UnlockFeaturesText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return text(
      "Unlock Features with Pro",
      maxLine: 2,
      isLongText: true,
      fontSize: textSizeMedium,
      fontWeight: FontWeight.w600,
    ).paddingTop(spacing_twinty);
  }
}

class PlanSelectionRow extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final double containerWidth;
  final double containerHeight;

  PlanSelectionRow({
    required this.selectedIndex,
    required this.onSelect,
    required this.containerWidth,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PlanContainer(
          title: "WEEKLY",
          price: "\$x.xx /week",
          index: 0,
          isSelected: selectedIndex == 0,
          onSelect: onSelect,
          width: containerWidth,
          height: containerHeight,
        ),
        PlanContainer(
          title: "MONTHLY",
          price: "\$x.xx /month",
          subText: "(\$xxx / Week)",
          index: 1,
          isSelected: selectedIndex == 1,
          onSelect: onSelect,
          width: containerWidth,
          height: containerHeight,
        ),
      ],
    ).paddingTop(spacing_twinty);
  }
}

class PlanContainer extends StatelessWidget {
  final String title;
  final String price;
  final String? subText;
  final int index;
  final bool isSelected;
  final ValueChanged<int> onSelect;
  final double width;
  final double height;

  PlanContainer({
    required this.title,
    required this.price,
    this.subText,
    required this.index,
    required this.isSelected,
    required this.onSelect,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(title, fontSize: textSizeMedium, fontWeight: FontWeight.w700),
            text(price, fontSize: textSizeMedium, fontWeight: FontWeight.w700, color: primaryColor),
            if (subText != null)
              text(subText!, fontSize: textSizeSMedium, fontWeight: FontWeight.w300, color: textGreyColor),
          ],
        ),
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return elevatedButton(
      context,
      onPress: () {},
      child: text("Get Started", fontSize: textSizeMedium, fontWeight: FontWeight.w600),
    ).paddingTop(spacing_twinty);
  }
}

class GetStartedAgreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.white, fontSize: textSizeSmall),
          children: [
            const TextSpan(text: "By clicking Get Started, you agree to our "),
            TextSpan(
              text: "Terms",
              style: TextStyle(color: primaryColor),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(text: " & "),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(color: primaryColor),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    ).paddingTop(spacing_standard_new);
  }
}

class AutoRenewInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text("Renews Automatically", color: Colors.white, fontSize: textSizeSmall),
        text("•", color: Colors.white, fontSize: textSizeSmall),
        text("Cancel Anytime", color: Colors.white, fontSize: textSizeSmall),
      ],
    ).paddingSymmetric(horizontal: 16).paddingTop(spacing_standard_new);
  }
}
