import 'package:coursezy/shared/styles/colors.dart';
import 'package:coursezy/shared/styles/text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool? showIcon;
  final double? width;
  final double? height;
  final Widget? icon;

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.showIcon = false,
    this.width,
    this.height = 65,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: AppColor.bluePrimary,
          foregroundColor: AppColor.white,
          textStyle: TextStyles.gilroyBold16,
        ),
        onPressed: () async {
          onPressed();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(label.toUpperCase(), style: TextStyles.gilroyBold16),
            ),
            showIcon == true
                ? icon ??
                    Positioned(
                      right: 0,
                      height: 30,
                      width: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.blueButton,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_forward, color: AppColor.white),
                      ),
                    )
                : Container(),
          ],
        ),
      ),
    );
  }
}
