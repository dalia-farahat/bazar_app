import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/nav_tap_zones.dart';
import '../widgets/screen_scaffold.dart';
import 'detail_menu_screen.dart';
import 'menu_screen.dart';
import 'menu_search_screen.dart';
import 'profile_screen.dart';

/// شاشة "4. Home" (فجما `249:3009`) - واجهة المتجر.
/// أطول إطار في الملف 375 x 1082، فـ [ScreenScaffold] بيعملها scroll كقطعة واحدة.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          // +44 عشان شريط حالة موبايل متشال من الرسم، فالارتفاع بيزيد معاه
          // عشان الشريط السفلي يفضل في نفس بُعد التصميم من تحت (من غير أبيض).
          height: 1082 + AppMetrics.statusBarHeight,
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
                left: 157,
                right: 158,
                top: 66,
                child: Text(
                  'Home',
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

              // ---- بانر العرض الخاص
              // الخلفية والظل والغلاف صورة واحدة (التصميم بيعتمد ضبابية غلاف للظل)،
              // والنصوص جوه نفس مجموعة 327 عشان لو الشاشة أعرض ما تسيبش الكارت.
              Positioned(
                left: 0,
                right: 0,
                top: 116,
                child: Center(
                  child: SizedBox(
                    width: 327,
                    height: 162,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: 0,
                          width: 327,
                          height: 146,
                          child: Image.asset(
                            'assets/figma/home-banner-card.png',
                          ),
                        ),
                        const Positioned(
                          left: 23,
                          top: 24,
                          child: Text('Special Offer', style: AppText.h4),
                        ),
                        const Positioned(
                          left: 23,
                          top: 52,
                          child: Text('Discount 25%', style: AppText.body14Ink),
                        ),
                        Positioned(
                          left: 23,
                          top: 86,
                          width: 118,
                          height: 36,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              SlidePageRoute<void>(page: const MenuScreen()),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Text(
                                'Order Now',
                                style: AppText.pillLabel,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 151.5,
                          top: 154,
                          child: _BannerDot(size: 8, color: AppColors.primary),
                        ),
                        const Positioned(
                          left: 163.5,
                          top: 156,
                          child: _BannerDot(
                            size: 4,
                            color: AppColors.primary100,
                          ),
                        ),
                        const Positioned(
                          left: 171.5,
                          top: 156,
                          child: _BannerDot(
                            size: 4,
                            color: AppColors.primary100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ---- قسم Top of Week
              const Positioned(
                left: 24,
                top: 305,
                child: Text('Top of Week', style: AppText.h5),
              ),
              const Positioned(
                right: 18,
                width: 48,
                top: 307,
                child: Text('See all', style: AppText.seeAll),
              ),
              _bookCard(context, 0, 'home-book-1.png', '\$14.99'),
              _bookCard(context, 1, 'home-book-2.png', '\$20.99'),
              _bookCard(context, 2, 'home-book-3.png', '\$14.99'),

              // ---- قسم Best Vendors
              const Positioned(
                left: 24,
                top: 575,
                child: Text('Best Vendors', style: AppText.h5),
              ),
              const Positioned(
                right: 20,
                width: 48,
                top: 577,
                child: Text('See all', style: AppText.seeAll),
              ),
              _vendorTile(
                0,
                'home-vendor-1.png',
                logoW: 67,
                logoH: 50,
                logoLeft: 7,
                logoTop: 15,
              ),
              _vendorTile(
                1,
                'home-vendor-2.png',
                logoW: 70,
                logoH: 48,
                logoLeft: 5,
                logoTop: 16,
              ),
              _vendorTile(
                2,
                'home-vendor-3.png',
                logoW: 70,
                logoH: 21,
                logoLeft: 5,
                logoTop: 29,
              ),
              _vendorTile(
                3,
                'home-vendor-4.png',
                logoW: 70,
                logoH: 8,
                logoLeft: 5,
                logoTop: 36,
              ),

              // ---- قسم Authors
              const Positioned(
                left: 24,
                top: 727,
                child: Text('Authors', style: AppText.h5),
              ),
              const Positioned(
                right: 20,
                width: 48,
                top: 729,
                child: Text('See all', style: AppText.seeAll),
              ),
              _author(
                0,
                'home-author-1.png',
                avatarLeft: 24,
                avatarTop: 785,
                avatarSize: 102,
                name: 'John Freeman',
                role: 'Writer',
              ),
              _author(
                1,
                'home-author-2.png',
                // الصورة التانية أكبر شوية من إطارها 102، فجبناها 106 x 106
                // وحطيناها عند (158, 782).
                avatarLeft: 158,
                avatarTop: 782,
                avatarSize: 106,
                name: 'Tess Gunty',
                role: 'Novelist',
              ),
              _author(
                2,
                'home-author-3.png',
                avatarLeft: 294,
                avatarTop: 785,
                avatarSize: 102,
                name: 'Richard Perston',
                role: 'Writer',
              ),

              // ---- شريط التنقل السفلي
              Positioned(
                left: 0,
                // +44 عشان شريط الحالة متشال، فالشريط يفضل في نفس موضع التصميم
                // (999 + 83 = 1082).
                top: 999 + AppMetrics.statusBarHeight,
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
                            top: 12.75,
                            child: SvgPicture.asset(
                              'assets/svg/nav-icon-home.svg',
                              width: 24,
                              height: 25.5,
                            ),
                          ),
                          const Positioned(
                            left: 44,
                            top: 40.38,
                            width: 33,
                            child: Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: AppText.navLabelActive,
                            ),
                          ),
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
                          // مناطق الضغط للتابات التلاتة (الحالي Home): وسطها
                          // 61 / 188 / 315.
                          NavTapZones(
                            onCategory: () => Navigator.of(context).push(
                              SlidePageRoute<void>(page: const MenuScreen()),
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

  /// كارت واحد في صف "Top of Week": غلاف 127 x 150 + العنوان والسعر.
  /// كل كارت بعد اللي قبله بـ 139 ابتداء من 24، واللي يعدي حدود الشاشة بيتشال.
  Widget _bookCard(
    BuildContext context,
    int index,
    String cover,
    String price,
  ) {
    final double left = 24.0 + 139 * index;
    return Positioned(
      left: left,
      top: 345,
      width: 127,
      height: 198,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(
          context,
        ).push(SlidePageRoute<void>(page: const DetailMenuScreen())),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset(
                'assets/figma/$cover',
                width: 127,
                height: 150,
              ),
            ),
            const Positioned(
              left: 0,
              top: 158,
              child: Text('The Kite Runner', style: AppText.cardTitle),
            ),
            Positioned(
              left: 0,
              top: 182,
              child: Text(price, style: AppText.price),
            ),
          ],
        ),
      ),
    );
  }

  /// كارت بائع 80 x 80 واللوجو في نفس موضعه في التصميم بالظبط.
  /// [logoW] و [logoH] لازم يتكتبوا عشان الصورة 4x، وإلا الرسام هياخد البكسلات الخام.
  Widget _vendorTile(
    int index,
    String logo, {
    required double logoW,
    required double logoH,
    required double logoLeft,
    required double logoTop,
  }) {
    final double left = 24.0 + 88 * index;
    return Positioned(
      left: left,
      top: 615,
      width: 80,
      height: 80,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          Positioned(
            left: logoLeft,
            top: logoTop,
            child: Image.asset(
              'assets/figma/$logo',
              width: logoW,
              height: logoH,
            ),
          ),
        ],
      ),
    );
  }

  /// كارت كاتب في صف "Authors": صورة دائرية + اسم + وظيفة.
  /// كل كارت بعد اللي قبله بـ 135 ابتداء من 24، والتالت بيعدي حدود الشاشة فبيتشال.
  Widget _author(
    int index,
    String photo, {
    required double avatarLeft,
    required double avatarTop,
    required double avatarSize,
    required String name,
    required String role,
  }) {
    final double cardLeft = 24.0 + 135 * index;
    return Positioned(
      left: cardLeft,
      top: 767,
      width: 127,
      height: 183,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            left: avatarLeft - cardLeft,
            top: avatarTop - 767,
            child: Image.asset(
              'assets/figma/$photo',
              width: avatarSize,
              height: avatarSize,
            ),
          ),
          Positioned(
            left: 0,
            // نزّلنا النص بكسل عشان يظبط مكانه زي باقي الشاشات.
            top: 134,
            child: Text(name, style: AppText.body16Medium),
          ),
          Positioned(
            left: 0,
            top: 163,
            child: Text(role, style: AppText.body14Tight),
          ),
        ],
      ),
    );
  }
}

/// نقطة ترقيم في كاروسيل البانر (الكبيرة = الحالي).
class _BannerDot extends StatelessWidget {
  const _BannerDot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
