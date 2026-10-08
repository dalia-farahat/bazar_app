// اختبارات الكيبورد ومقاس البورد الثابت 375x812.
// كان فيه حاجتين بيكسره: نافذة أقصر من 812 بتضغط البورد فوق الكيبورد،
// والكيبورد فوق column طوله بورد بالظبط بيقفل الـ scroll فلا حد يوصل لآخره.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bazar_app/main.dart';
import 'package:bazar_app/screens/sign_in_screen.dart';
import 'package:bazar_app/screens/sign_up_screen.dart';
import 'package:bazar_app/screens/verification_email_screen.dart';
import 'package:bazar_app/widgets/app_text_field.dart';
import 'package:bazar_app/widgets/numeric_keypad.dart';
import 'package:bazar_app/widgets/otp_input.dart';
import 'package:bazar_app/widgets/primary_button.dart';
import 'package:bazar_app/widgets/terms_text.dart';

import 'test_fonts.dart';

const double _keyboard = 300;

const double _board = 812;

const double _aboveKeyboard = _board - _keyboard;

/// نافذة أقصر من البورد كله (بروفايل Small_Phone).
const Size _shortWindow = Size(375, 667);

/// التطبيق يفتح مباشرة على شاشة sign-in.
///
/// الاختبارات دي عن الكيبورد، مش عن الـ splash ولا الـ onboarding
/// اللي بتيجي قبلها في التطبيق الحقيقي.
const BazarApp _signInApp = BazarApp(home: SignInScreen());

Future<void> _pumpApp(
  WidgetTester tester,
  Widget app, {
  Size physicalSize = const Size(375, _board),
  double keyboard = _keyboard,
}) async {
  tester.view.physicalSize = physicalSize;
  tester.view.devicePixelRatio = 1;
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

/// الـ scroll الخارجي اللي شايل البورد كله.
ScrollableState _boardScrollable(WidgetTester tester) {
  return tester.state<ScrollableState>(find.byType(Scrollable).first);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadAppFonts);

  testWidgets('sign-in tail scrolls clear of the keyboard', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester, _signInApp);

    final ScrollableState board = _boardScrollable(tester);
    expect(
      board.position.maxScrollExtent,
      greaterThan(0),
      reason:
          'the column is as tall as the art-board, so without the '
          'keyboard clearance nothing below the keyboard could ever be '
          'reached',
    );

    board.position.jumpTo(board.position.maxScrollExtent);
    await tester.pumpAndSettle();

    expect(
      tester.getRect(find.text('Sign in with Apple')).bottom,
      lessThanOrEqualTo(_aboveKeyboard),
    );
    expect(
      tester
          .getRect(
            find.text("Don't have an account? Sign Up", findRichText: true),
          )
          .bottom,
      lessThanOrEqualTo(_aboveKeyboard),
    );
  });

  testWidgets('sign-in tail is reachable in a short window with the keyboard', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester, _signInApp, physicalSize: _shortWindow);

    final ScrollableState board = _boardScrollable(tester);
    expect(board.position.maxScrollExtent, greaterThan(0));

    board.position.jumpTo(board.position.maxScrollExtent);
    await tester.pumpAndSettle();

    expect(
      tester.getRect(find.text('Sign in with Apple')).bottom,
      lessThanOrEqualTo(_shortWindow.height - _keyboard),
    );
  });

  testWidgets('verification content stays above the keyboard', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester, const MaterialApp(home: VerificationEmailScreen()));

    expect(
      find.byType(NumericKeypad),
      findsNothing,
      reason:
          'the keypad, the frame content and the keyboard cannot all fit '
          'above the keyboard, so the keypad steps aside instead of being '
          'stacked against it',
    );
    expect(
      tester.getRect(find.byType(OtpInput)).bottom,
      lessThanOrEqualTo(_aboveKeyboard),
    );
    expect(
      tester.getRect(find.byType(PrimaryButton)).bottom,
      lessThanOrEqualTo(_aboveKeyboard),
    );
  });

  testWidgets(
    'verification keypad opens on the OTP and closes again, board stays clear',
    (WidgetTester tester) async {
      await _pumpApp(
        tester,
        const MaterialApp(home: VerificationEmailScreen()),
        physicalSize: _shortWindow,
        keyboard: 0,
      );

      // الشاشة بتبدأ نضيفة: مفيش لوحة أرقام لحد ما ندوس على خانات الـ OTP.
      expect(find.byType(NumericKeypad), findsNothing);

      await tester.tap(find.byType(OtpInput));
      await tester.pumpAndSettle();
      expect(find.byType(NumericKeypad), findsOneWidget);

      // الضغط بره الخانات بيقفلها تاني.
      await tester.tap(find.text('Verification Email'));
      await tester.pumpAndSettle();
      expect(find.byType(NumericKeypad), findsNothing);

      await tester.tap(find.byType(OtpInput));
      await tester.pumpAndSettle();

      final ScrollableState board = _boardScrollable(tester);
      expect(
        board.position.maxScrollExtent,
        greaterThan(0),
        reason:
            'an art-board taller than the window must scroll instead of '
            'being squashed onto it',
      );

      final Finder keypad = find.byType(NumericKeypad);
      expect(
        tester.getRect(find.byType(PrimaryButton)).bottom,
        lessThanOrEqualTo(tester.getRect(keypad).top),
        reason: 'the column must not run underneath the keypad',
      );

      board.position.jumpTo(board.position.maxScrollExtent);
      await tester.pumpAndSettle();

      expect(
        tester.getRect(keypad).bottom,
        lessThanOrEqualTo(_shortWindow.height),
        reason: 'the whole keypad must be scrollable into view',
      );
    },
  );

  testWidgets('sign-up terms stay clear of the content in a short window', (
    WidgetTester tester,
  ) async {
    await _pumpApp(
      tester,
      const MaterialApp(home: SignUpScreen()),
      physicalSize: _shortWindow,
      keyboard: 0,
    );

    final Rect terms = tester.getRect(find.byType(TermsText));
    final Rect signInLine = tester.getRect(
      find.text('Have an account? Sign In', findRichText: true),
    );

    expect(
      terms.top,
      greaterThanOrEqualTo(signInLine.bottom),
      reason:
          'a squashed art-board would drag the bottom-pinned terms footer '
          'up onto the sign-in line',
    );
    expect(
      terms.top,
      greaterThanOrEqualTo(
        tester.getRect(find.byType(AppTextField).last).bottom,
      ),
    );
  });

  testWidgets('navigating away from a focused field drops the keyboard', (
    WidgetTester tester,
  ) async {
    await _pumpApp(tester, _signInApp, keyboard: 0);

    final EditableText email = tester.widget<EditableText>(
      find.byType(EditableText).first,
    );
    await tester.tap(find.byType(TextField).first);
    await tester.pump();
    expect(email.focusNode.hasFocus, isTrue);

    await tester.tap(
      find.text("Don't have an account? Sign Up", findRichText: true),
    );
    await tester.pumpAndSettle();

    expect(
      email.focusNode.hasFocus,
      isFalse,
      reason:
          'the keyboard raised on one frame must not be left floating '
          'over the next one',
    );
  });
}
