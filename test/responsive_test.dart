// بندّي كل شاشة عن طريق BazarApp (جذر التطبيق الحقيقي بالـ FixedDesignScaler)
// على مقاسات شاشة تانية غير بورد Figma، ونتأكد إن الرسم مفيهوش overflow
// أو clip أو استثناء والنافذة أصغر (أو أكبر) من التصميم.
//
//     flutter test test/responsive_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bazar_app/main.dart';
import 'package:bazar_app/screens/detail_menu_screen.dart';
import 'package:bazar_app/screens/favorites_screen.dart';
import 'package:bazar_app/screens/help_center_screen.dart';
import 'package:bazar_app/screens/home_screen.dart';
import 'package:bazar_app/screens/logout_screen.dart';
import 'package:bazar_app/screens/menu_screen.dart';
import 'package:bazar_app/screens/menu_search_screen.dart';
import 'package:bazar_app/screens/my_account_screen.dart';
import 'package:bazar_app/screens/onboarding_screen.dart';
import 'package:bazar_app/screens/order_history_screen.dart';
import 'package:bazar_app/screens/phone_number_screen.dart';
import 'package:bazar_app/screens/profile_screen.dart';
import 'package:bazar_app/screens/set_location_screen.dart';
import 'package:bazar_app/screens/sign_in_screen.dart';
import 'package:bazar_app/screens/sign_up_screen.dart';
import 'package:bazar_app/screens/splash_screen.dart';
import 'package:bazar_app/screens/success_screen.dart';
import 'package:bazar_app/screens/verification_email_screen.dart';
import 'package:bazar_app/screens/verification_phone_screen.dart';
import 'package:bazar_app/screens/verification_screen.dart';

import 'test_fonts.dart';

void _noop() {}

void main() {
  setUpAll(loadAppFonts);

  const List<Size> sizes = <Size>[
    Size(375, 812), // بورد Figma نفسه
    Size(320, 568), // أصغر موبايل واقعي (iPhone SE 1)
    Size(360, 640), // أندرويد صغير
    Size(412, 915), // أندرويد طويل حديث
    Size(768, 1024), // تابلت بالطول
  ];

  final Map<String, Widget Function()> screens = <String, Widget Function()>{
    'splash': () => const SplashScreen(autoAdvance: false),
    'onboarding': () => const OnboardingScreen(page: 0),
    'sign-in': () => const SignInScreen(),
    'sign-up': () => const SignUpScreen(),
    'phone-number': () => const PhoneNumberScreen(),
    'verification': () => VerificationScreen(
      title: 'Verification',
      subtitleLead: 'We just sent an OTP to ',
      subtitleTail: 'johndoe@email.com',
      onContinue: _noop,
    ),
    'verification-email': () => const VerificationEmailScreen(),
    'verification-phone': () => const VerificationPhoneScreen(),
    'set-location': () => const SetLocationScreen(),
    'success': () => const SuccessScreen(),
    'home': () => const HomeScreen(),
    'menu': () => const MenuScreen(),
    'menu-search': () => const MenuSearchScreen(),
    'detail-menu': () => const DetailMenuScreen(),
    'favorites': () => const FavoritesScreen(),
    'order-history': () => const OrderHistoryScreen(),
    'profile': () => const ProfileScreen(),
    'my-account': () => const MyAccountScreen(),
    'help-center': () => const HelpCenterScreen(),
    'logout': () => const LogoutScreen(),
  };

  for (final MapEntry<String, Widget Function()> screen in screens.entries) {
    for (final Size size in sizes) {
      final String label =
          '${screen.key} @ ${size.width.toInt()}x${size.height.toInt()}';
      testWidgets('fits $label', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        // من خلال BazarApp عشان MaterialApp.builder يطبّق الـ scaler
        // بنفس طريقة التطبيق الحقيقي بالظبط.
        await tester.pumpWidget(BazarApp(home: screen.value()));
        await tester.pumpAndSettle();

        // بنسحب كل استثناءات الفريم؛ أي حاجة فاضلة (overflow أو
        // RenderBox assertion ...) تخلّي الاختبار يفشل.
        final List<String> errors = <String>[];
        Object? error;
        while ((error = tester.takeException()) != null) {
          errors.add(error.toString());
        }
        expect(
          errors,
          isEmpty,
          reason: 'layout problems while rendering $label',
        );
      });
    }
  }
}
