// اختبارات الـscaler الموحد: حساب الـfit، حالات الحماية، وتحويل
// insets الكيبورد من بكسل حقيقي لوحدات الكانفاس.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bazar_app/widgets/fixed_design_scaler.dart';

void main() {
  group('scaleFor', () {
    test('is 1.0 on the exact art-board', () {
      expect(FixedDesignScaler.scaleFor(375, 812), 1.0);
    });

    test('fits by the limiting axis', () {
      // موبايل أندرويد ضيق (زي جوالات سامسونج): العرض هو المحدد.
      expect(FixedDesignScaler.scaleFor(360, 780), closeTo(0.96, 1e-9));
      // موبايل طويل حديث: العرض محدد والارتفاع فيه فاضي.
      expect(FixedDesignScaler.scaleFor(412, 915), closeTo(412 / 375, 1e-9));
      // نافذة قصيرة: الارتفاع هو المحدد.
      expect(FixedDesignScaler.scaleFor(375, 667), closeTo(667 / 812, 1e-9));
      // نافذة سطح مكتب: الارتفاع محدد وما فيش قص للعرض.
      expect(FixedDesignScaler.scaleFor(1920, 1080), closeTo(1080 / 812, 1e-9));
    });

    test('degrades to 1.0 instead of crashing on degenerate input', () {
      expect(FixedDesignScaler.scaleFor(0, 0), 1.0);
      expect(FixedDesignScaler.scaleFor(-375, 812), 1.0);
      expect(FixedDesignScaler.scaleFor(375, double.nan), 1.0);
      expect(FixedDesignScaler.scaleFor(double.infinity, 812), 1.0);
    });
  });

  group('canvasMediaQuery', () {
    test('canvas size is window / scale', () {
      const MediaQueryData source = MediaQueryData(size: Size(360, 780));
      final double scale = FixedDesignScaler.scaleFor(360, 780);
      final MediaQueryData canvas = FixedDesignScaler.canvasMediaQuery(
        source,
        scale,
        const Size(360 / 0.96, 780 / 0.96),
      );
      expect(canvas.size.width, closeTo(375, 1e-9));
      expect(canvas.size.height, closeTo(812.5, 1e-9));
    });

    test('keyboard inset is divided by the scale so it survives painting', () {
      const MediaQueryData source = MediaQueryData(
        size: Size(375, 667),
        viewInsets: EdgeInsets.only(bottom: 300),
      );
      final double scale = FixedDesignScaler.scaleFor(375, 667);
      final MediaQueryData canvas = FixedDesignScaler.canvasMediaQuery(
        source,
        scale,
        const Size(375 / 0.8214, 667 / 0.8214),
      );
      // ٣٠٠ بكسل حقيقي بتتقسم على الـscale فتصير وحدات كانفاس،
      // ولما تترسم تاني لازم ترجع ٣٠٠ بالظبط.
      final double painted = canvas.viewInsets.bottom * scale;
      expect(painted, closeTo(300, 1e-6));
    });

    test('pins the text scale so system font settings cannot reflow', () {
      const MediaQueryData source = MediaQueryData(
        size: Size(375, 812),
        textScaler: TextScaler.linear(1.3),
      );
      final MediaQueryData canvas = FixedDesignScaler.canvasMediaQuery(
        source,
        1.0,
        const Size(375, 812),
      );
      expect(canvas.textScaler.scale(16), 16.0);
    });
  });
}
