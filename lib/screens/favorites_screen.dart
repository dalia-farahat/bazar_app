import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';
import 'detail_menu_screen.dart';
import 'menu_screen.dart';

/// شاشة "Your Favorites" — قائمة الكتب المحفوظة.
/// نفس صفوف [MenuScreen] بس كل صف هنا بيعرض قلبه الأحمر، ومن غير شريط تنقل سفلي.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
                left: 115,
                right: 115,
                top: 66,
                child: Text(
                  'Your Favorites',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle,
                ),
              ),

              // صفوف الكتب
              for (int i = 0; i < MenuScreen.rows.length; i++) _row(context, i),
            ],
          ),
        ),
      ],
    );
  }

  /// نفس صف [MenuScreen] بس بنضيف القلب عشان ده الهدف الأساسي في الشاشة دي.
  Widget _row(BuildContext context, int index) {
    final (String title, String price) = MenuScreen.rows[index];
    final double top = 116.0 + 80 * index;
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
            Positioned(
              right: 32,
              top: top + 28,
              child: SvgPicture.asset(
                'assets/svg/detail-icon-love.svg',
                width: 24,
                height: 24,
              ),
            ),
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
