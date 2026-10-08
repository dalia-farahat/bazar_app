import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// زر مصمت من التصميم.
/// المقاس الافتراضي (327 x 48 ونصف قطر 24) بتاع شاشات الدخول،
/// وكل شاشة تقدر تغيّر المقاس أو اللون بالـarguments الاختيارية.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width = AppMetrics.buttonWidth,
    this.height = AppMetrics.buttonHeight,
    this.radius = AppMetrics.buttonRadius,
    this.background = AppColors.primary,
    this.labelStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final double radius;
  final Color background;

  /// لو مفيش نمط متحدد بيتقع على [AppText.h6] الافتراضي.
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: labelStyle ?? AppText.h6,
            ),
          ),
        ),
      ),
    );
  }
}
