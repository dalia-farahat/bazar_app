// بنتأكد إن عناصر كذا جزء بتفضل علاقاتها لما عرض الـ canvas يبقى أوسع من
// بورد 375 (بانر + نصوصه، صورة متمركزة، صف النجوم، كروت التواصل...).
// الـ rects بتيجي في بكسلات النافذة، يعني: نص النافذة ± إزاحة التصميم × scale.
//
//     flutter test test/wide_layout_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bazar_app/main.dart';
import 'package:bazar_app/screens/detail_menu_screen.dart';
import 'package:bazar_app/screens/help_center_screen.dart';
import 'package:bazar_app/screens/home_screen.dart';
import 'package:bazar_app/screens/onboarding_screen.dart';
import 'package:bazar_app/widgets/primary_button.dart';

import 'test_fonts.dart';

double _scaleOf(double w, double h) {
  final double sx = w / 375;
  final double sy = h / 812;
  return sx < sy ? sx : sy;
}

Finder _asset(String name) => find.byWidgetPredicate(
  (Widget w) =>
      w is Image &&
      w.image is AssetImage &&
      (w.image as AssetImage).assetName == name,
);

void main() {
  setUpAll(loadAppFonts);

  // موبايل المستخدم (437x812، scale 1) ونافذة تابلت (scale 1.26).
  const List<Size> sizes = <Size>[Size(437, 812), Size(768, 1024)];

  for (final Size size in sizes) {
    final double k = _scaleOf(size.width, size.height);
    final double mid = size.width / 2; // نص النافذة لأن الـ canvas بيملاها
    final String tag = '${size.width.toInt()}x${size.height.toInt()}';

    testWidgets('banner group stays one unit @ $tag', (WidgetTester t) async {
      t.view.physicalSize = size;
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      await t.pumpWidget(const BazarApp(home: HomeScreen()));
      await t.pumpAndSettle();

      final Rect card = t.getRect(_asset('assets/figma/home-banner-card.png'));
      expect(card.width, closeTo(327 * k, 1), reason: 'banner width @ $tag');
      expect(card.center.dx, closeTo(mid, 1), reason: 'banner centre @ $tag');
      for (final String label in <String>[
        'Special Offer',
        'Discount 25%',
        'Order Now',
      ]) {
        final Rect r = t.getRect(find.text(label));
        expect(
          card.contains(r.topLeft) && card.contains(r.bottomRight),
          isTrue,
          reason:
              '"$label" must sit inside the banner card @ $tag '
              '(card=$card text=$r)',
        );
      }
    });

    testWidgets('detail cover is canvas-centred @ $tag', (
      WidgetTester t,
    ) async {
      t.view.physicalSize = size;
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      await t.pumpWidget(const BazarApp(home: DetailMenuScreen()));
      await t.pumpAndSettle();

      final Rect cover = t.getRect(_asset('assets/figma/detail-book.png'));
      expect(cover.width, closeTo(237 * k, 1), reason: 'cover width @ $tag');
      expect(cover.center.dx, closeTo(mid, 1), reason: 'cover centre @ $tag');
    });

    testWidgets('contact-card pair keeps its gap @ $tag', (
      WidgetTester t,
    ) async {
      t.view.physicalSize = size;
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      await t.pumpWidget(const BazarApp(home: HelpCenterScreen()));
      await t.pumpAndSettle();

      final Rect email = t.getRect(find.text('Email'));
      final Rect phone = t.getRect(find.text('Phone Number'));
      // المجموعة بعرض 332 وسط النافذة (يسار 21 / يمين 22 → إزاحة -0.5)،
      // نصوص الكروت بداخلها 16 والكارت التاني مبعود +174.
      expect(
        email.left,
        closeTo(mid - 150.5 * k, 2 * k),
        reason: 'email card @ $tag',
      );
      expect(
        phone.left - email.left,
        closeTo(174 * k, 2 * k),
        reason: 'card pitch must stay 174 @ $tag',
      );
    });

    testWidgets('onboarding buttons stretch to the gutters @ $tag', (
      WidgetTester t,
    ) async {
      t.view.physicalSize = size;
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      await t.pumpWidget(const BazarApp(home: OnboardingScreen(page: 0)));
      await t.pumpAndSettle();

      // getSize() بيرجع وحدات التصميم؛ getRect() بيرجع مكانها في النافذة.
      final Rect btn = t.getRect(find.byType(PrimaryButton).first);
      expect(
        btn.width,
        closeTo(size.width - 48 * k, 1),
        reason: 'button width @ $tag',
      );
    });
  }
}
