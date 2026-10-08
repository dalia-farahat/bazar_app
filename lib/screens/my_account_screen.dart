import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';

/// شاشة "My Account" — نموذج تعديل البيانات الشخصية.
/// حقلين (الاسم والإيميل) وزر "Save Changes"، من غير شريط تنقل سفلي.
class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: AppMetrics.screenHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // شريط الأدوات
              Positioned(
                left: 24,
                top: 68,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Image.asset(
                    'assets/figma/loc-icon-back.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const Positioned(
                left: 63,
                top: 66,
                width: 118,
                child: Text(
                  'My Account',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle,
                ),
              ),

              // الخانات
              const Positioned(
                left: 24,
                top: 121,
                child: Text('Name', style: AppText.body14Medium),
              ),
              _fieldBox(147),
              // الـ -1 تصحيح بسيط في الارتفاع عشان النص يظبط مع باقي العناصر.
              const Positioned(
                left: 40,
                top: 158,
                child: Text('John', style: AppText.body16Medium),
              ),
              const Positioned(
                left: 24,
                top: 211,
                child: Text('Email', style: AppText.body14Medium),
              ),
              _fieldBox(237),
              const Positioned(
                left: 40,
                top: 248,
                child: Text('Johndoe@email.com', style: AppText.body16Medium),
              ),

              // زر الحفظ
              Positioned(
                left: 24,
                right: 24,
                top: 314,
                height: AppMetrics.buttonHeight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                    ),
                    child: const Text('Save Changes', style: AppText.h6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// صندوق الخانة نفسه، بنستخدمه لكل حقل عشان مكرّرش الكود.
  Widget _fieldBox(double top) {
    return Positioned(
      left: 24,
      right: 24,
      top: top,
      height: AppMetrics.fieldHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.gray50,
          borderRadius: BorderRadius.circular(AppMetrics.fieldRadius),
          border: Border.all(color: AppColors.gray200),
        ),
      ),
    );
  }
}
