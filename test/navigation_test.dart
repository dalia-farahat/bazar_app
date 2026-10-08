// اختبار تنقّل سريع: Login -> Home، وتبويبات الشريط السفلي، وصفوف البروفايل.
//
// بندّي على بورد طوله 1082 (طول الهوم نفسه) عشان كل الصفحة تتحط من غير
// scroll وكل أماكن الضغط تفضل على إحداثياتها الأصلية.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bazar_app/main.dart';
import 'package:bazar_app/screens/sign_in_screen.dart';

import 'test_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);

  /// الـ splash/onboarding موجودة في `widget_test.dart`؛ فهنا نبدأ من
  /// شاشة sign-in، نضغط Login، ونوصل Home.
  Future<void> pumpHome(WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 1082);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const BazarApp(home: SignInScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Top of Week'), findsOneWidget);
  }

  testWidgets('Category tab opens the menu and a row opens Detail', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);

    // الشريط نازل 41 عشان تعويض شريط الحالة المحذوف، فـ y بتوع التصميم
    // بقت 999 + 41؛ ونطاق Category في نص العرض x 188.
    await tester.tapAt(const Offset(187, 1040));
    await tester.pumpAndSettle();
    expect(find.text('Bibendum facilisis.'), findsOneWidget);

    await tester.tap(find.text('In in amet ultrices sit.'));
    await tester.pumpAndSettle();
    expect(find.text('The Kite Runner'), findsOneWidget);

    // رجعنا للمينيو وبعدين ضغطنا تبويب الهوم (الشريط عند y 729 بتوع التصميم).
    await tester.tap(find.text('Continue shopping'));
    await tester.pumpAndSettle();
    expect(find.text('Bibendum facilisis.'), findsOneWidget);

    await tester.tapAt(const Offset(61, 770));
    await tester.pumpAndSettle();
    expect(find.text('Top of Week'), findsOneWidget);
  });

  testWidgets('Profile rows open My Account and the tabs keep working', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);

    // تبويب البروفايل عند x 315، وبعدها صف "My Account".
    await tester.tapAt(const Offset(315, 1040));
    await tester.pumpAndSettle();
    expect(find.text('John Doe'), findsOneWidget);

    // فوق الصف الأول في شريط مخفي هو اللي بياخد الضغط (y 212..284 ناقص
    // 44 = 168..240)، عشان كده ضغطنا عند 204.
    await tester.tapAt(const Offset(122, 204));
    await tester.pumpAndSettle();
    expect(find.text('Save Changes'), findsOneWidget);

    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();
    expect(find.text('John Doe'), findsOneWidget);

    // تبويب الهوم على شريط البروفايل: y 729 + 41 = 770.
    await tester.tapAt(const Offset(61, 770));
    await tester.pumpAndSettle();
    expect(find.text('Top of Week'), findsOneWidget);
  });
}
