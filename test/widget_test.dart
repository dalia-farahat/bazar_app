// اختبار سريع للفلو كله: splash -> onboarding -> sign-in -> sign-up.
// بنتأكد إن التطبيق يفتح على splash، وبعدين onboarding، وبعدين يوصل sign-in،
// وإن زرار الـ call-to-action الأساسي في كل شاشة موجود.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bazar_app/main.dart';
import 'package:bazar_app/screens/sign_in_screen.dart';

import 'test_fonts.dart';

/// بتفتح [app] على بورد 375x812 اللي الشاشات اترسمت عليه.
///
/// نافذة الاختبار 800x600 كانت هتقص نص البورد فلا زرار تحت y = 600 يتدوس.
Future<void> _pumpOnArtboard(WidgetTester tester, Widget app) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);

  testWidgets('splash -> onboarding -> sign-in', (WidgetTester tester) async {
    await _pumpOnArtboard(tester, const BazarApp());
    // فريم واحد بس: pumpAndSettle بيدّي 100ms في كل خطوة، فالـ splash timer
    // كان هيشتغل قبل ما نلحق نشوف الشاشة.
    await tester.pump();
    expect(find.text('Bazar.'), findsOneWidget);

    // الـ splash بيحوّل لوحده بعد ما يخلّص مدة انتظاره.
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Now reading books will be easier'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Your Bookish Soulmate Awaits'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Start Your Adventure'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back \u{1F44B}'), findsOneWidget);
    expect(find.text('Sign to your account'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Or with'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text('Sign in with Apple'), findsOneWidget);
  });

  testWidgets('"Skip" jumps straight to sign-in', (WidgetTester tester) async {
    await _pumpOnArtboard(tester, const BazarApp());
    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back \u{1F44B}'), findsOneWidget);
  });

  testWidgets('"Sign Up" link opens the sign-up frame', (
    WidgetTester tester,
  ) async {
    await _pumpOnArtboard(tester, const BazarApp(home: SignInScreen()));
    await tester.pumpAndSettle();

    final Finder link = find.text(
      "Don't have an account? Sign Up",
      findRichText: true,
    );
    expect(link, findsOneWidget);
    await tester.tap(link);
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);
    expect(
      find.text('Create account and choose favorite menu'),
      findsOneWidget,
    );
    expect(find.text('Register'), findsOneWidget);
    expect(
      find.text('Have an account? Sign In', findRichText: true),
      findsOneWidget,
    );
  });
}
