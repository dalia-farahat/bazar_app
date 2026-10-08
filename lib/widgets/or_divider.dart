import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// فاصل "Or with": خطين رفيعين والكلام متوسط في الفراغ بينهم.
/// الخط الأول من 0..158 والتاني من 217..375، والكلام في 165..210.
class OrWithDivider extends StatelessWidget {
  const OrWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 12,
            width: 158,
            child: Container(height: 1, color: AppColors.gray200),
          ),
          Positioned(
            left: 217,
            top: 12,
            width: 158,
            child: Container(height: 1, color: AppColors.gray200),
          ),
          const Text('Or with', style: AppText.body14),
        ],
      ),
    );
  }
}
