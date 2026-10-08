import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';

/// شاشة "Help Center" — اختيارات التواصل (إيميل أو تليفون).
/// هيدر بنفسجي فوق وجسم أبيض تحته، وعنوان الشريط مكتوب "Order History" في التصميم فسبناه زي ما هو.
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  /// سطرين وسط جوه الهيدر، والإيموجي جزء منهم.
  static const String subtitleLine1 = 'Tell us how we can help';
  static const String subtitleLine2 =
      'Chapter are standing by for service & support!';

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      background: AppColors.primary,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: AppMetrics.screenHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // الهيدر البنفسجي والجسم الأبيض
              const Positioned(
                left: 0,
                top: 252,
                right: 0,
                height: AppMetrics.screenHeight - 252,
                child: ColoredBox(color: AppColors.white),
              ),

              // شريط الأدوات
              Positioned(
                left: 24,
                top: 68,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Image.asset(
                    'assets/figma/help-icon-back.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Positioned(
                left: 119,
                right: 119,
                top: 66,
                child: Text(
                  'Order History',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle.copyWith(color: AppColors.gray50),
                ),
              ),

              // عنوان الهيدر
              const Positioned(
                left: 139,
                top: 123,
                width: 135,
                child: Text(
                  'Help Center',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppText.headingFamily,
                    fontSize: 24,
                    height: 32.40 / 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.72,
                    color: AppColors.white,
                  ),
                ),
              ),
              // الـ -1 تصحيح بسيط في الارتفاع عشان النص يظبط.
              // السطرين مفصلين عشان كل سطر يتوسط لوحده صح، والإيموجي صورة لأن الخط مفيهوش رموز ملونة فكان هيختفي.
              Positioned(
                left: 44,
                top: 163,
                width: 305,
                child: Text(
                  subtitleLine1,
                  textAlign: TextAlign.center,
                  style: AppText.body16.copyWith(color: AppColors.primary200),
                ),
              ),
              Positioned(
                left: 284,
                top: 164,
                child: Image.asset(
                  'assets/figma/help-wave-emoji.png',
                  width: 20,
                  height: 20,
                ),
              ),
              Positioned(
                left: 44,
                top: 187,
                width: 325,
                child: Text(
                  subtitleLine2,
                  textAlign: TextAlign.center,
                  style: AppText.body16.copyWith(color: AppColors.primary200),
                ),
              ),

              // كروت التواصل
              // الكروتين جوه جروب واحد وسط، عشان المسافة 16 بينهم تفضل ثابتة مهما كانت الشاشة أعرض.
              Positioned(
                left: 21,
                right: 22,
                top: 280,
                height: 151,
                child: Center(
                  child: SizedBox(
                    width: 332,
                    height: 151,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: <Widget>[
                        _contactCard(
                          left: 0,
                          icon: 'assets/figma/help-icon-email.png',
                          label: 'Email',
                          caption: 'Send to your email',
                        ),
                        _contactCard(
                          left: 174,
                          icon: 'assets/figma/help-icon-phone.png',
                          label: 'Phone Number',
                          caption: 'Send to your phone',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// كارت تواصل واحد بمقاس 158 x 151 جوه جروب الكروت.
  Widget _contactCard({
    required double left,
    required String icon,
    required String label,
    required String caption,
  }) {
    return Positioned(
      left: left,
      top: 0,
      width: 158,
      height: 151,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.gray50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.gray100),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            Positioned(
              left: 16,
              top: 23.5,
              width: 48,
              height: 48,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 35.5,
              child: Image.asset(icon, width: 24, height: 24),
            ),
            Positioned(
              left: 16,
              top: 87.5,
              child: Text(label, style: AppText.body14Medium),
            ),
            Positioned(
              left: 16,
              top: 107.5,
              child: Text(
                caption,
                style: AppText.body14.copyWith(color: AppColors.gray500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
