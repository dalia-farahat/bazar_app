import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';

/// شاشة "Order History" — الطلبات السابقة مجمّعة بالشهر.
/// كارت واحد فيه 3 طلبات (صورة + عنوان + حالة ملونة + عدد الأصناف)، من غير شريط تنقل سفلي.
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  /// (العنوان، الحالة، لون الحالة، عدد الأصناف، رقم الصورة).
  static const List<(String, String, Color, String, int)> orders =
      <(String, String, Color, String, int)>[
        ('The Da vinci Code', 'Delivered', AppColors.green500, '1 items', 1),
        ('Carrie Fisher', 'Delivered', AppColors.green500, '5 items', 2),
        ('The Waiting', 'Cancelled', AppColors.red, '2 items', 3),
      ];

  /// لون العنوان gray/900 وخطه Roboto بوزن 600.
  /// مفيش خط 600 محمّل، فـ Flutter بيرجّع Roboto Bold بدل منه.
  static const TextStyle _titleStyle = TextStyle(
    fontFamily: AppText.family,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

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
                left: 119,
                right: 119,
                top: 66,
                child: Text(
                  'Order History',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle,
                ),
              ),

              // كارت الشهر
              const Positioned(
                left: 24,
                top: 124,
                child: Text('October 2021', style: AppText.h5),
              ),
              Positioned(
                left: 24,
                right: 24,
                top: 164,
                height: 240,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.gray200),
                  ),
                ),
              ),
              for (int i = 0; i < orders.length; i++) _orderRow(i),
            ],
          ),
        ),
      ],
    );
  }

  /// صف طلب واحد بإحداثيات ثابتة زي التصميم.
  Widget _orderRow(int index) {
    final (
      String title,
      String status,
      Color statusColor,
      String items,
      int thumb,
    ) = orders[index];
    final double top = 180.0 + 80 * index;
    final bool last = index == orders.length - 1;
    // النقطة والعدّاد بيتحركوا شمين عشان كلمة Cancelled أطول من Delivered.
    final double dotX = status == 'Cancelled' ? 174 : 171;
    final double countX = status == 'Cancelled' ? 186 : 183;
    return Positioned.fill(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          Positioned(
            left: 40,
            top: top,
            child: Image.asset(
              'assets/figma/menu-thumb-$thumb.png',
              width: 48,
              height: 48,
            ),
          ),
          // الـ -1 تصحيح بسيط في الارتفاع عشان العنوان يظبط مع باقي نصوص الصف.
          Positioned(
            left: 104,
            top: top - 1,
            child: Text(title, style: _titleStyle),
          ),
          Positioned(
            left: 104,
            top: top + 28,
            child: Text(
              status,
              style: AppText.body14Medium.copyWith(color: statusColor),
            ),
          ),
          Positioned(
            left: dotX,
            top: top + 36,
            width: 4,
            height: 4,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.gray200,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: countX,
            top: top + 28,
            child: Text(
              items,
              style: AppText.body14Medium.copyWith(color: AppColors.gray600),
            ),
          ),
          if (!last)
            Positioned(
              left: 24,
              right: 24,
              top: top + 63,
              height: 1,
              child: const ColoredBox(color: AppColors.gray200),
            ),
        ],
      ),
    );
  }
}
