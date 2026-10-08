import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/nav_tap_zones.dart';
import '../widgets/screen_scaffold.dart';
import 'detail_menu_screen.dart';
import 'home_screen.dart';
import 'menu_search_screen.dart';
import 'profile_screen.dart';

/// شاشة "5 Menu" (فجما `89:3217`) - صفحة قائمة التصنيفات.
/// 375 x 812: شريط تصنيفات فوق + 4 صفوف كتب + شريط تنقل سفلي، Category نشط.
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  /// عنوان الكتاب وسعره في كل صف (الأول فوق والآخر تحت).
  static const List<(String, String)> rows = <(String, String)>[
    ('In in amet ultrices sit.', '\$19.99'),
    ('Bibendum facilisis.', '\$27.12'),
    ('Nulla et diam cras.', '\$13.52'),
    ('Risus malesuada in.', '\$31.00'),
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
                  onTap: () => Navigator.of(
                    context,
                  ).push(SlidePageRoute<void>(page: const MenuSearchScreen())),
                  child: SvgPicture.asset(
                    'assets/svg/home-icon-search.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              const Positioned(
                left: 142,
                right: 143,
                top: 66,
                child: Text(
                  'Category',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle,
                ),
              ),
              Positioned(
                right: 24,
                top: 68,
                child: SvgPicture.asset(
                  'assets/svg/home-icon-bell.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              // علامة إن في إشعار جديد لسه.
              Positioned(
                right: 27,
                top: 68,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.white, width: 1),
                    ),
                  ),
                ),
              ),

              // ---- شريط التصنيفات
              // النصوص نزلناها بكسل، عشان Flutter بيحط سطر 16/24 ناقص بكسل عن
              // مكانه في فجما فبنظبطه بـ -1، وعناوين الصفوف نفس التصحيح (+15).
              const Positioned(
                left: 24,
                top: 116,
                child: Text('All', style: AppText.h5),
              ),
              // الخط تحت "All" عشان يبان إنه التصنيف النشط.
              Positioned(
                left: 31,
                top: 142,
                width: 8,
                height: 2,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
              const Positioned(
                left: 71,
                top: 117,
                child: Text('Novels', style: AppText.body16),
              ),
              const Positioned(
                left: 144,
                top: 117,
                child: Text('Self Love', style: AppText.body16),
              ),
              const Positioned(
                left: 234,
                top: 117,
                child: Text('Science', style: AppText.body16),
              ),
              const Positioned(
                left: 314,
                top: 117,
                child: Text('Romantic', style: AppText.body16),
              ),

              // ---- صفوف الكتب
              for (int i = 0; i < rows.length; i++) _row(context, i),

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
                          // أيقونة Home رمادية لأنه مش نشط هنا، عشان الصورة
                          // البنفسجي مخصوصة لشاشة Home.
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
                          // Category هو النشط هنا، فالصورته بنفسجية ووسطها
                          // x = 188 (مفيش تبويب Cart).
                          Positioned(
                            left: 176,
                            top: 12.75,
                            child: Image.asset(
                              'assets/figma/menu-icon-category.png',
                              width: 24,
                              height: 25.5,
                            ),
                          ),
                          const Positioned(
                            left: 163,
                            top: 40.38,
                            width: 49,
                            child: Text(
                              'Category',
                              textAlign: TextAlign.center,
                              style: AppText.navLabelActive,
                            ),
                          ),
                          Positioned(
                            left: 303,
                            top: 16,
                            child: SvgPicture.asset(
                              'assets/svg/nav-icon-profile.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const Positioned(
                            left: 297,
                            top: 42,
                            width: 35,
                            child: Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: AppText.navLabel,
                            ),
                          ),
                          // مناطق الضغط للتابات التلاتة (الحالي Category).
                          NavTapZones(
                            onHome: () => Navigator.of(context).push(
                              SlidePageRoute<void>(page: const HomeScreen()),
                            ),
                            onProfile: () => Navigator.of(context).push(
                              SlidePageRoute<void>(page: const ProfileScreen()),
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

  /// صف كتب ارتفاعه 80 ابتداء من `160 + 80 * index`: صورة 48 وعنوان وسعر وخط فاصل.
  /// مفيش heart جنب الصفوف حسب التصميم النهائي فمكانش موجود.
  Widget _row(BuildContext context, int index) {
    final (String title, String price) = rows[index];
    final double top = 160.0 + 80 * index;
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () => Navigator.of(
          context,
        ).push(SlidePageRoute<void>(page: const DetailMenuScreen())),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            Positioned(
              left: 24,
              top: top + 16,
              child: Image.asset(
                'assets/figma/menu-thumb-${index + 1}.png',
                width: 48,
                height: 48,
              ),
            ),
            // +15 عشان نفس تصحيح السطر اللي فوق في شريط التصنيفات.
            Positioned(
              left: 88,
              top: top + 15,
              child: Text(title, style: AppText.body16Medium),
            ),
            Positioned(
              left: 88,
              top: top + 44,
              child: Text(price, style: AppText.seeAll),
            ),
            // الخط الفاصل بينزل على آخر بكسل من الصف (عقدة LINE عند y 240).
            Positioned(
              left: 0,
              top: top + 79,
              right: 0,
              height: 1,
              child: const ColoredBox(color: AppColors.gray200),
            ),
          ],
        ),
      ),
    );
  }
}
