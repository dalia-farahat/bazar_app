import 'package:flutter/material.dart';

/// ألوان التصميم من Figma — "2. Sign in & Sign up" (4244:3643).
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF54408C);

  static const Color primary300 = Color(0xFFA28CE0);

  /// نقاط البانر غير النشطة.
  static const Color primary100 = Color(0xFFE5DEF8);

  static const Color gray900 = Color(0xFF121212);

  static const Color gray500 = Color(0xFFA6A6A6);

  static const Color gray400 = Color(0xFFB8B8B8);

  /// للحدود والفواصل.
  static const Color gray200 = Color(0xFFE8E8E8);

  /// خلفية الحقول وصناديق الكود.
  static const Color gray50 = Color(0xFFFAFAFA);

  /// زر الترحيب الثانوي؛ قريب من [gray50] جدًا بس أخدش شوية فمش بديل عنها.
  static const Color primary50 = Color(0xFFFAF9FD);

  static const Color white = Color(0xFFFFFFFF);

  static const Color red = Color(0xFFEF5A56);

  static const Color green = Color(0xFF34A853);

  static const Color blue = Color(0xFF3784FB);

  static const Color yellow = Color(0xFFF5BE00);

  /// أخضر نجاح حالة "تم التوصيل" (9.4).
  static const Color green500 = Color(0xFF18A057);

  /// الرمادي الهادي بتاع عدّاد القطع (9.4).
  static const Color gray600 = Color(0xFF7A7A7A);

  /// حدود كروت شاشة المساعدة (9.5).
  static const Color gray100 = Color(0xFFF5F5F5);

  /// العنوان الفرعي في شاشة المساعدة (9.5).
  static const Color primary200 = Color(0xFFCABCEF);

  /// سطر "Write something for us!" في بطاقة التقييم (7.3).
  static const Color gray1000 = Color(0xFF09031B);
}

/// أنماط الخط في التصميم: العناوين Open Sans والنصوص Roboto،
/// وكل القيم (الحجم والارتفاع والسماكة) مأخوذة من Figma زي ما هي.
class AppText {
  AppText._();

  static const String family = 'Roboto';

  /// العناوين بخط Open Sans مش Roboto لأن التصميم معمول بيه.
  static const String headingFamily = 'Open Sans';

  /// Heading/H3 من التصميم.
  static const TextStyle h3 = TextStyle(
    fontFamily: headingFamily,
    fontSize: 24,
    height: 32.40 / 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.72,
    color: AppColors.gray900,
  );

  /// Heading/H6 — نص الأزرار.
  static const TextStyle h6 = TextStyle(
    fontFamily: headingFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    color: AppColors.white,
  );

  /// letterSpacing مكتوب هنا صريح عشان تتبع Material 3 الافتراضي
  /// ما يتسرّبش في كل Text ويوسّع السطر.
  static const TextStyle body16 = TextStyle(
    fontFamily: family,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  /// Body/16/Medium من التصميم.
  static const TextStyle body16Medium = TextStyle(
    fontFamily: family,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  /// Body/14/Regular من التصميم.
  static const TextStyle body14 = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  /// Body/14/Medium من التصميم.
  static const TextStyle body14Medium = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  /// التصميم طلب وزن 600 فحطينا 700 لأنه الأقرب المتوفر.
  static const TextStyle body14Semibold = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.primary,
  );

  /// نص أزرار السوشيال — التصميم طلب وزن 450 فحطينا 500.
  static const TextStyle socialLabel = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 24 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  /// عنوان بانر "Special Offer" في الرئيسية (4. Home).
  static const TextStyle h4 = TextStyle(
    fontFamily: headingFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.60,
    color: AppColors.gray900,
  );

  /// عناوين الأقسام: "Top of Week" و"Best Vendors" و"Authors".
  static const TextStyle h5 = TextStyle(
    fontFamily: headingFamily,
    fontSize: 18,
    height: 24.30 / 18,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.54,
    color: AppColors.gray900,
  );

  /// عنوان شريط الأعلى ("Home").
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: headingFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  /// رابط "See all".
  static const TextStyle seeAll = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.30,
    color: AppColors.primary,
  );

  /// نص الزر المصمت ("Order Now").
  static const TextStyle pillLabel = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.30,
    color: AppColors.white,
  );

  /// "Discount 25%" بتاع البانر.
  static const TextStyle body14Ink = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  /// زي [body14] بس بارتفاع السطر 19.60 زي ما التصميم محدده
  /// (كده ربع سطر ضيق أشطر للعناوين الصغيرة).
  static const TextStyle body14Tight = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  /// عناوين كروت الكتب.
  static const TextStyle cardTitle = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.gray900,
  );

  /// أسعار الكتب.
  static const TextStyle price = TextStyle(
    fontFamily: family,
    fontSize: 12,
    height: 16.20 / 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.30,
    color: AppColors.primary,
  );

  /// لسان التبويب النشط في الشريط السفلي.
  static const TextStyle navLabelActive = TextStyle(
    fontFamily: family,
    fontSize: 12,
    height: 16.20 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.primary,
  );

  /// لسان التبويبات غير النشطة.
  static const TextStyle navLabel = TextStyle(
    fontFamily: family,
    fontSize: 12,
    height: 16.20 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.gray500,
  );

  /// زرار "Skip" في شاشات الترحيب.
  static const TextStyle skip = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 19.60 / 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.primary,
  );

  /// اسم "Bazar." في شاشة البداية.
  static const TextStyle logo = TextStyle(
    fontFamily: family,
    fontSize: 31.55,
    height: 44.16 / 31.55,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.26,
    color: AppColors.white,
  );
}

/// مقاسات الـframe المشترك 375 x 812.
class AppMetrics {
  AppMetrics._();

  /// مقاس الـframe في التصميم.
  static const double screenWidth = 375;
  static const double screenHeight = 812;

  /// هامش جانبي ثابت لكل الشاشات.
  static const double gutter = 24;

  /// العرض المتاح بين الهامشين.
  /// بنديه للطفل بإجابة صارمة عشان الـText اللي وسطه center يتوسط فعلًا.
  static const double contentWidth = screenWidth - 2 * gutter;

  /// الأزرار الأساسية والثانوية.
  static const double buttonWidth = 327;
  static const double buttonHeight = 48;
  static const double buttonRadius = 24;

  /// حقول الكتابة.
  static const double fieldWidth = 327;
  static const double fieldHeight = 48;
  static const double fieldRadius = 8;

  /// صناديق كود التحقق.
  static const double otpBox = 52;
  static const double otpRadius = 8;
  static const double otpGap = 16;

  /// ارتفاع شريط الحالة وشريط الأسفل.
  static const double statusBarHeight = 44;
}
