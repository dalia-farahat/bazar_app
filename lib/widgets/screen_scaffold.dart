import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'back_button.dart';

/// الهامش الجانبي 24px المشترك بين كل الشاشات، والطفل بياخد العرض كله بإجابة
/// صارمة عشان نص قصير ميقلّصش نفسه ويبوظ الـcenter.
/// [dy] تحريك للرسم بس من غير تغيير في الـlayout، عشان النصوص تظبط على التصميم.
class Gutter extends StatelessWidget {
  const Gutter({super.key, this.dy = 0, required this.child});

  /// إزاحة رأسية للرسم فقط (الـlayout زي ما هو).
  final double dy;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // الطفل بياخد إجابة صارمة (عرض اللوح ناقص الهامشين)، عشان Column الـstart
    // ميسيبش نص قصير يضيّق نفسه ويفسد TextAlign.center. وعلى شاشة 375
    // بيطلع 327 بالظبط، وأي شاشة أوسع بتكبر بنفس الشكل من الجهتين.
    final Widget row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppMetrics.gutter),
      child: SizedBox(width: double.infinity, child: child),
    );
    if (dy == 0) {
      return row;
    }
    return Transform.translate(offset: Offset(0, dy), child: row);
  }
}

/// إطار مشترك لكل شاشات "2. Sign in & Sign up": art-board أبيض عرضه 375
/// في نص الشاشة + زرار رجوع اختياري + طبقة سفلية اختيارية (الكيبورد).
/// الـchildren في عمود بيتحرك من فوق لتحت، وكل شاشة بتحط spacer عشان أماكنها.
class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.children,
    this.showBack = false,
    this.footer,
    this.bottom,
    this.bottomInset = 0,
    this.contentDx = 0,
    this.background = AppColors.white,
  });

  final List<Widget> children;

  /// يرسم زرار الرجوع 40 x 40 عند (16, 16) حسب التصميم.
  final bool showBack;

  /// ملزوق على بعد 56px من أسفل الشاشة (نص الشروط في التسجيل).
  final Widget? footer;

  /// طبقة سفلية بعرض كامل، زي الكيبورد الرقمي.
  final Widget? bottom;

  /// مساحة بتتحجز تحت الـchildren عشان [bottom]، لأنها طبقة مطلقة فوق العمود.
  /// من غيرها كان المحتوى الأطول بيدخل تحت الطبقة ومفيش طريقة تسحبه بره.
  /// والحالات التانية (شاشة أقصر / كيبورد) بيتتعامل معاها في [build].
  final double bottomInset;

  /// إزاحة أفقية للرسم بس لزرار الرجوع والمحتوى (الـlayout زي ما هو).
  /// إطار 2.3 في التصميم مزحزح بكسل لليمين عن باقي الفريمات فبنعوّضه هنا،
  /// أما [footer] فمش بيتأثر بالإزاحة دي.
  final double contentDx;

  /// لون خلفية الـart-board: أبيض في شاشات الدخول، وبنفسجي في شاشة البداية.
  final Color background;

  Widget _nudged(Widget child) {
    if (contentDx == 0) {
      return child;
    }
    return Transform.translate(offset: Offset(contentDx, 0), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      // الـart-board تركيب ثابت ما يقلش عن 812px؛ لو الشاشة أقصر كان
      // الكيبورد ونص الشروط بيتزحلقوا فوق العمود، فبنخلي اللوح كله
      // يتسكرول كوحدة وبناخد viewInsets حوالينه بدل الـresize.
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double boardHeight = math.max(
            constraints.maxHeight,
            AppMetrics.screenHeight,
          );
          // محتاجين viewInsets مع إن resizeToAvoidBottomInset مطفي،
          // عشان نحجز مكان الكيبورد ونحرك اللوح فوقه كله.
          final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(bottom: keyboardInset),
              child: SizedBox(
                height: boardHeight,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      right: 0,
                      // أول 44px في التصميم مكانهم شريط حالة الموبايل مش تصميم،
                      // فبنبدأ نافذة السكرول من عندهم عشان الشريط يتشال من
                      // الـlayout ومتفضلش شريط بيضا تحت الشريط السفلي.
                      top: -AppMetrics.statusBarHeight,
                      bottom: 0,
                      child: _nudged(
                        SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: bottomInset),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: children,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (showBack)
                      Positioned(
                        left: 16,
                        // 60 - statusBarHeight: نفس طريقة شيل شريط الـ44px
                        // عشان الزرار نفسه متموضع على الـart-board.
                        top: 60 - AppMetrics.statusBarHeight,
                        child: _nudged(const AppBackButton()),
                      ),
                    if (footer != null)
                      Positioned(left: 0, right: 0, bottom: 56, child: footer!),
                    // مع الكيبورد المفتوح مفيش مكان للكيبورد الرقمي فوقه
                    // والمحتوى تحته في نفس الوقت، فالاتنين هيتحطوا فوق
                    // بعض؛ فهو بيختفي لحد ما الكيبورد يقفل.
                    if (bottom != null && keyboardInset == 0)
                      Positioned(left: 0, right: 0, bottom: 0, child: bottom!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
