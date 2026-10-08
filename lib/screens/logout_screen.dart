import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';
import 'sign_in_screen.dart';

/// "9.6 Logout" (فجما `2110:3848`) - تأكيد الخروج فوق شاشة Profile
/// (خلفيتها متغمّقة 30%): شيت أبيض من y 500 فيه Logout وزرارين Logout/Cancel.
class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  /// نص التأكيد في الشيت (Body/16 رمادي غامق، سطرين).
  static const String bodyCopy =
      'Lorem Ipsum is simply dummy text of the printing and '
      'typesetting industry.';

  /// الصفوف الأربعة اللي باقية فوق الشيت مع إحداثيات أسهمها.
  /// (سهم الصف التالت نازل 32 بكسل عن بداية صفه.)
  static const List<
    ({String label, String icon, double chevronX, double chevronY})
  >
  menu = <({String label, String icon, double chevronX, double chevronY})>[
    (
      label: 'My Account',
      icon: 'profile-icon-account.png',
      chevronX: 330,
      chevronY: 236,
    ),
    (
      label: 'Address',
      icon: 'profile-icon-location.png',
      chevronX: 329,
      chevronY: 308,
    ),
    (
      label: 'Your Favorites',
      icon: 'detail-icon-love.svg',
      chevronX: 332,
      chevronY: 380,
    ),
    (
      label: 'Order History',
      icon: 'profile-icon-document.png',
      chevronX: 330,
      chevronY: 460,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      // الأبيض تحت طبقة التغميق بيبقى #B8B8B8، فحطيناه كخلفية مباشرة.
      background: const Color(0xFFB8B8B8),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: AppMetrics.screenHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              const Positioned.fill(child: ColoredBox(color: AppColors.white)),

              // ---- شريط الأعلى (app bar)
              Positioned(
                left: 24,
                top: 68,
                child: Image.asset(
                  'assets/figma/loc-icon-back.png',
                  width: 24,
                  height: 24,
                ),
              ),
              const Positioned(
                left: 154,
                right: 155,
                top: 66,
                child: Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle,
                ),
              ),

              // ---- الخط الفاصل الأول
              const Positioned(
                left: 0,
                top: 123,
                right: 0,
                height: 1,
                child: ColoredBox(color: AppColors.gray200),
              ),

              // ---- بيانات المستخدم
              Positioned(
                left: 24,
                top: 140,
                child: Image.asset(
                  'assets/figma/logout-avatar.png',
                  width: 56,
                  height: 56,
                ),
              ),
              Positioned(
                left: 96,
                top: 145,
                child: Text(
                  'John Doe',
                  style: AppText.h6.copyWith(color: AppColors.gray900),
                ),
              ),
              const Positioned(
                left: 96,
                top: 171,
                child: Text('(+1) 234 567 890', style: AppText.body14Tight),
              ),
              Positioned(
                right: 24,
                width: 46,
                top: 158,
                child: Text(
                  'Logout',
                  style: AppText.seeAll.copyWith(color: AppColors.red),
                ),
              ),

              // ---- الخط الفاصل التاني
              const Positioned(
                left: 0,
                top: 211,
                right: 0,
                height: 1,
                child: ColoredBox(color: AppColors.gray200),
              ),

              // ---- صفوف القائمة
              for (int i = 0; i < menu.length; i++) _menuRow(i),

              // ---- طبقة التغميق
              // #121212 بنسبة 30%، والـ alpha مقلّعينه عشان الأبيض تحتها يطلع
              // #B8B8B8 مش #B7B7B7.
              const Positioned.fill(
                child: ColoredBox(color: Color(0x4C121212)),
              ),

              // ---- شيت التأكيد
              Positioned(
                left: 0,
                top: 500,
                right: 0,
                height: 312,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: <Widget>[
                      // مقبض السحب: القطعة 56 متوسطة جوه صندوق left/right
                      // ثابت، عشان تفضل وسط الشيت حتى لو الشاشة أعرض من 375.
                      Positioned(
                        left: 159,
                        right: 160,
                        top: 17,
                        height: 5,
                        child: Center(
                          child: SizedBox(
                            width: 56,
                            height: 5,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.gray200,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 24,
                        top: 40,
                        child: Text('Logout', style: AppText.h5),
                      ),
                      // نزّلنا النص بكسل عشان يظبط مكانه زي باقي الشاشات.
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 79,
                        child: Text(
                          bodyCopy,
                          style: AppText.body16.copyWith(
                            color: AppColors.gray900,
                          ),
                        ),
                      ),

                      // ---- زرار Logout الأساسي
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 152,
                        height: AppMetrics.buttonHeight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                            SlidePageRoute<void>(page: const SignInScreen()),
                            (Route<dynamic> route) => false,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(48),
                              ),
                            ),
                            child: const Text('Logout', style: AppText.h6),
                          ),
                        ),
                      ),

                      // ---- زرار Cancel
                      Positioned(
                        left: 24,
                        right: 24,
                        top: 216,
                        height: AppMetrics.buttonHeight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.primary50,
                              borderRadius: BorderRadius.all(
                                Radius.circular(48),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: AppText.h6.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// صف قائمة 72 بكسل: دائرة رمادية فيها الأيقونة + النص + سهم في إحداثياته.
  /// النص نزّلناه بكسل عشان يظبط مكانه زي باقي الشاشات.
  Widget _menuRow(int index) {
    final (:String label, :String icon, :double chevronX, :double chevronY) =
        menu[index];
    final double rowTop = 212.0 + 72 * index;
    final Widget glyph = icon.endsWith('.svg')
        ? SvgPicture.asset('assets/svg/$icon', width: 20, height: 20)
        : Image.asset('assets/figma/$icon', width: 20, height: 20);
    return Positioned.fill(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            left: 24,
            top: rowTop + 16,
            width: 40,
            height: 40,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.primary50,
                shape: BoxShape.circle,
              ),
              child: Center(child: glyph),
            ),
          ),
          Positioned(
            left: 80,
            top: rowTop + 23,
            child: Text(label, style: AppText.body16Medium),
          ),
          Positioned(
            right: AppMetrics.screenWidth - chevronX - 24,
            top: chevronY,
            child: Image.asset(
              'assets/figma/chevron-right.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
