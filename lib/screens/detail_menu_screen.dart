import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';

/// "4.3 Detail Menu" (فجما `44:1267`) - كرت الكتاب فوق شاشة Home المغمّقة.
/// الشيت الأبيض من y 44 بزوايا فوق بس، والمحتوى كله في نفس إحداثيات الإطار.
class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key});

  /// نص الوصف بتاع الإطار `169:5839` - تلات سطور Body/14.
  static const String blurb =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.';

  /// ستايل "(4.0)" جنب نجوم التقييم: Body/14/Semibold بلون gray/900.
  /// التصميم كاتب w600 وما معندناش الخط ده فبنستخدم Roboto Bold زي [AppText.body14Semibold].
  static const TextStyle _ratingLabel = TextStyle(
    fontFamily: AppText.family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.gray900,
  );
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      background: AppColors.gray400,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: AppMetrics.screenHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // ---- الشيت الأبيض
              const Positioned(
                left: 0,
                right: 0,
                top: 44,
                height: 768,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                ),
              ),
              // مقبض السحب تحت حافة الشيت، متوسط بـ left/right عشان الصندوق
              // يفضل في مكانه والقطعة 56 تفضل وسط الشيت حتى لو الشاشة أعرض.
              Positioned(
                left: 159,
                right: 160,
                top: 61,
                height: 5,
                child: Center(
                  child: SizedBox(
                    width: 56,
                    height: 5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
              ),
              // ---- الغلاف
              Positioned(
                left: 0,
                right: 0,
                top: 85,
                child: Center(
                  child: SizedBox(
                    width: 237,
                    height: 313,
                    child: Image.asset('assets/figma/detail-book.png'),
                  ),
                ),
              ),
              // ---- العنوان
              const Positioned(
                left: 24,
                top: 414,
                child: Text('The Kite Runner', style: AppText.h4),
              ),
              Positioned(
                right: 24,
                top: 414,
                child: SvgPicture.asset(
                  'assets/svg/detail-icon-love.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              // شارة التقييم "4.6" البرتقالية، مجمّعة في التصميم عند
              // (24.68, 454.70).
              Positioned(
                left: 24,
                top: 454,
                child: Image.asset(
                  'assets/figma/detail-rating.png',
                  width: 80,
                  height: 24,
                ),
              ),
              const Positioned(
                left: 24,
                right: 40,
                top: 490,
                child: Text(blurb, style: AppText.body14Tight),
              ),
              // ---- قسم Review
              const Positioned(
                left: 24,
                top: 574,
                child: Text('Review', style: AppText.h5),
              ),
              for (int i = 0; i < 5; i++)
                Positioned(
                  left: 24.0 + 28 * i,
                  top: 606,
                  child: SvgPicture.asset(
                    'assets/svg/detail-icon-star.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              const Positioned(
                left: 164,
                top: 606,
                child: Text('(4.0)', style: _ratingLabel),
              ),
              // ---- العدّاد والسعر
              Positioned(
                left: 24,
                top: 654,
                width: 106,
                height: 40,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.gray50,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      // زرار النقصان: دائرة رمادية بعلامة سالب.
                      const Positioned(
                        left: 8,
                        top: 8,
                        width: 24,
                        height: 24,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.gray200,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 14.33,
                        top: 19,
                        width: 11.33,
                        height: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.gray500,
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 48,
                        top: 8,
                        child: Text('1', style: AppText.body16Medium),
                      ),
                      // زرار الزيادة: دائرة أساسية بعلامة زائد.
                      const Positioned(
                        left: 74,
                        top: 8,
                        width: 24,
                        height: 24,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 85,
                        top: 14.33,
                        width: 2,
                        height: 11.33,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 80.33,
                        top: 19,
                        width: 11.33,
                        height: 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 146,
                top: 662,
                child: Text(
                  '\$39.99',
                  style: AppText.body16Medium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              // ---- الأزرار
              // زرار واحد بعرض المحتوى 327، ومفيش زرار "View cart" حسب
              // التصميم النهائي.
              Positioned(
                left: 0,
                right: 0,
                top: 704,
                height: 48,
                child: Center(
                  child: SizedBox(
                    width: 327,
                    height: 48,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(48)),
                        ),
                        child: const Text(
                          'Continue shopping',
                          style: AppText.h6,
                        ),
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
}
