import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

/// زرار أبيض بحد رفيع 327 x 48 لـ"Sign in with Google/Apple".
/// الأيقونة والنص جوّا صندوق 156px مركزي، عشان نص الزرارين يبدأ من نفس
/// النقطة x = 141 على الرغم من إن عرض محتواهم مختلف.
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.iconAsset,
    this.onPressed,
  });

  final String label;
  final String iconAsset;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.buttonRadius),
        side: const BorderSide(color: AppColors.gray200, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: AppMetrics.buttonWidth,
          height: AppMetrics.buttonHeight,
          child: Center(
            child: SizedBox(
              width: 156,
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    iconAsset,
                    width: 16,
                    height: 16,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),
                  Text(label, style: AppText.socialLabel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
