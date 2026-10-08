import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// مقاس الـcanvas اللي التصميم اترسم عليه: عرض 375 و812 أدنى ارتفاع.
/// كل الفريمات عرضها 375 والطويلة بس بتنزل تحت، فالارتفاع ده أقل حاجة مطلوبة.
class DesignReference {
  const DesignReference._();

  static const double width = 375.0;
  static const double height = 812.0;
  static const Size size = Size(width, height);

  /// للأغراض التقنية بس، مش بيستخدم في الـlayout.
  static const double devicePixelRatio = 2.0;

  /// التطبيق شغال immersive وبيرسم شريط حالته بنفسه، فلازم نشيل كل الـinsets.
  static const EdgeInsets viewPadding = EdgeInsets.zero;
  static const EdgeInsets viewInsets = EdgeInsets.zero;
  static const EdgeInsets padding = EdgeInsets.zero;

  /// نثبّت تكبير الخط عشان التكوين يفضل زي ما هو بالظبط.
  static const double textScaleFactor = 1.0;
}

/// يكبّر التطبيق كله بنفس النسبة عشان أي مقاس شاشة يطلّع نفس التكوين.
/// سكيلر واحد بس لكل التطبيق: scale = min(عرض/375, ارتفاع/812) والرسم بـFittedBox.
/// ولا شاشة تكبّر نفسها من تاني — ده شغل الـwidget ده لوحده، والتاني هيتضاعف.
class FixedDesignScaler extends StatelessWidget {
  const FixedDesignScaler({super.key, required this.child});

  final Widget child;

  /// لون خلفية أمان ورا الـcanvas؛ مش بيتشاف إلا لو حصل مشكلة في الـlayout.
  static const Color letterboxColor = AppColors.white;

  /// نسبة التكبير لمقاس الشاشة المدورة.
  /// بنرجّع 1.0 بدل ما نرجّع 0 أو NaN، عشان أي مقاس غلط ما يوقّع التطبيق.
  static double scaleFor(double availableWidth, double availableHeight) {
    if (!availableWidth.isFinite ||
        !availableHeight.isFinite ||
        availableWidth <= 0.0 ||
        availableHeight <= 0.0) {
      return 1.0;
    }
    final double scale = math.min(
      availableWidth / DesignReference.width,
      availableHeight / DesignReference.height,
    );
    return (scale.isFinite && scale > 0.0) ? scale : 1.0;
  }

  /// الـMediaQuery اللي التطبيق هيشوفه: مقاسات الشاشة الحقيقية متحوّلة
  /// لوحدات الـcanvas.
  static MediaQueryData canvasMediaQuery(
    MediaQueryData source,
    double scale,
    Size canvasSize,
  ) {
    final EdgeInsets viewInsets = _toCanvasInsets(source.viewInsets, scale);
    const EdgeInsets viewPadding = DesignReference.viewPadding;

    final EdgeInsets padding = EdgeInsets.fromLTRB(
      math.max(0.0, viewPadding.left - viewInsets.left),
      math.max(0.0, viewPadding.top - viewInsets.top),
      math.max(0.0, viewPadding.right - viewInsets.right),
      math.max(0.0, viewPadding.bottom - viewInsets.bottom),
    );

    return source.copyWith(
      size: canvasSize,
      padding: padding,
      viewPadding: viewPadding,
      viewInsets: viewInsets,
      systemGestureInsets: _toCanvasInsets(source.systemGestureInsets, scale),
      textScaler: const TextScaler.linear(DesignReference.textScaleFactor),
    );
  }

  /// بيحوّل الـinset من بكسل حقيقي لوحدة canvas (بالقسمة على scale)،
  /// عشان لما يترسم يرجع مقاسه الحقيقي تاني.
  static EdgeInsets _toCanvasInsets(EdgeInsets insets, double scale) {
    if (scale == 1.0 || insets == EdgeInsets.zero) {
      return insets;
    }
    return EdgeInsets.only(
      left: insets.left / scale,
      top: insets.top / scale,
      right: insets.right / scale,
      bottom: insets.bottom / scale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final MediaQueryData media = MediaQuery.of(context);
        final double availableWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : media.size.width;
        final double availableHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : media.size.height;
        final double scale = scaleFor(availableWidth, availableHeight);

        // الـcanvas = الشاشة ÷ scale وبنفس نسبة الشاشة بالظبط،
        // فـBoxFit.fill بيساوي scale ويغطي الشاشة من غير أي فراغات.
        final double canvasWidth = availableWidth / scale;
        final double canvasHeight = availableHeight / scale;

        return ColoredBox(
          color: letterboxColor,
          child: ClipRect(
            child: SizedBox(
              width: availableWidth,
              height: availableHeight,
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: canvasWidth,
                  height: canvasHeight,
                  child: MediaQuery(
                    data: canvasMediaQuery(
                      media,
                      scale,
                      Size(canvasWidth, canvasHeight),
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
