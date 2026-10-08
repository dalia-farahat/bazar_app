import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/nav_tap_zones.dart';
import '../widgets/screen_scaffold.dart';
import 'favorites_screen.dart';
import 'help_center_screen.dart';
import 'home_screen.dart';
import 'logout_screen.dart';
import 'menu_screen.dart';
import 'my_account_screen.dart';
import 'order_history_screen.dart';

/// شاشة "9. Profile" (فجما `98:3712`) - صفحة نظرة على الحساب.
/// شريط أعلى بسهم رجوع + كتلة الهوية + 4 صفوف قائمة، Profile نشط ومفيش زرار dark mode.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  /// عناوين صفوف القائمة الأربعة مع صور أيقوناتها وإحداثيات السهم.
  /// (سهم الصف التالت نازل 8 بكسل عن مكانه في التصميم.)
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
      label: 'Your Favorites',
      icon: 'detail-icon-love.svg',
      chevronX: 332,
      chevronY: 308,
    ),
    (
      label: 'Order History',
      icon: 'profile-icon-document.png',
      chevronX: 330,
      chevronY: 388,
    ),
    (
      label: 'Help Center',
      icon: 'profile-icon-chat.png',
      chevronX: 329,
      chevronY: 452,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          // +44 عشان شريط الحالة متشال، فالارتفاع يزيد معاه عشان الشريط
          // السفلي يفضل في نفس بُعد التصميم من تحت (729 + 83 = 812).
          height: AppMetrics.screenHeight + AppMetrics.statusBarHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // ---- شريط الأعلى (app bar)
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
              // عقدة LINE عند y 124 بتترسم عند 123..124 (نفس قاعدة المنيو).
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
                  'assets/figma/profile-avatar.png',
                  width: 56,
                  height: 56,
                ),
              ),
              // نفس ستايل h6 بتاع الأزرار بس غيّرنا لونه، عشان الأصلي أبيض.
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
              // كلمة Logout حمرا عشان تفرق عن باقي بيانات الهوية.
              Positioned(
                right: 24,
                width: 46,
                top: 158,
                child: GestureDetector(
                  onTap: () => Navigator.of(
                    context,
                  ).push(SlidePageRoute<void>(page: const LogoutScreen())),
                  child: Text(
                    'Logout',
                    style: AppText.seeAll.copyWith(color: AppColors.red),
                  ),
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
              // مناطق ضغط شفافة فوق الصفوف، اتحطّت آخر حاجة عشان ما تغطيش
              // الرسم وتستقبل الضغط.
              for (int i = 0; i < menu.length; i++) _menuTap(context, i),

              // ---- شريط التنقل السفلي
              Positioned(
                left: 0,
                top: 729 + AppMetrics.statusBarHeight,
                right: 0,
                height: 83,
                child: ColoredBox(
                  color: AppColors.gray50,
                  // الشريط بيمتد على كل عرض الشاشة، أما الأيقونات فتفضل في
                  // نفس إحداثيات الـ 375 art-board ومقفولة بالنص.
                  child: Center(
                    child: SizedBox(
                      width: AppMetrics.screenWidth,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: <Widget>[
                          Positioned(
                            left: 49,
                            top: 16,
                            child: Image.asset(
                              'assets/figma/menu-icon-home.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Positioned(
                            left: 44,
                            top: 42,
                            width: 33,
                            child: Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: AppText.navLabel,
                            ),
                          ),
                          // Category وسطها x = 188 (مفيش تبويب Cart).
                          Positioned(
                            left: 176,
                            top: 16,
                            child: SvgPicture.asset(
                              'assets/svg/nav-icon-category.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Positioned(
                            left: 163,
                            top: 42,
                            width: 49,
                            child: Text(
                              'Category',
                              textAlign: TextAlign.center,
                              style: AppText.navLabel,
                            ),
                          ),
                          Positioned(
                            left: 303,
                            top: 16,
                            child: Image.asset(
                              'assets/figma/profile-nav-icon.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Positioned(
                            left: 296,
                            top: 42,
                            width: 36,
                            child: Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: AppText.navLabelActive,
                            ),
                          ),
                          // مناطق الضغط للتابات التلاتة (الحالي Profile).
                          NavTapZones(
                            onHome: () => Navigator.of(context).push(
                              SlidePageRoute<void>(page: const HomeScreen()),
                            ),
                            onCategory: () => Navigator.of(context).push(
                              SlidePageRoute<void>(page: const MenuScreen()),
                            ),
                          ),
                        ],
                      ),
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

  /// صف قائمة 72 بكسل: دائرة رمادية فيها الأيقونة + النص + سهم في إحداثياته
  /// في التصميم. النص نزّلناه بكسل عشان يظبط مكانه زي باقي الشاشات.
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

  /// مناطق ضغط شفافة على صفوف القائمة، مربوطة بنفس ترتيب [menu] عشان الضغط
  /// يوصل للصفحة الصح.
  Widget _menuTap(BuildContext context, int index) {
    final String label = menu[index].label;
    return Positioned(
      left: 0,
      right: 0,
      top: 212.0 + 72 * index,
      height: 72,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final Widget? page = switch (label) {
            'My Account' => const MyAccountScreen(),
            'Your Favorites' => const FavoritesScreen(),
            'Order History' => const OrderHistoryScreen(),
            'Help Center' => const HelpCenterScreen(),
            _ => null,
          };
          if (page != null) {
            Navigator.of(context).push(SlidePageRoute<void>(page: page));
          }
        },
        child: const SizedBox.expand(),
      ),
    );
  }
}
