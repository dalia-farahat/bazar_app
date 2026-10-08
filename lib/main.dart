import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/fixed_design_scaler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // التصميم بيرسم شريط الحالة وشريط الأسفل بنفسه،
  // فبنقفل شريط النظام عشان الـframe يفضل مضبوط.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  runApp(const BazarApp());
}

/// يقفل الكيبورد أول ما نتنقل بين الشاشات.
/// من غير كده كان يفضل واقف فوق الكيبورد البنفسجي ويزحم المحتوى تحته.
class _DismissKeyboardObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class BazarApp extends StatelessWidget {
  const BazarApp({super.key, this.home});

  /// أول شاشة يفتحها التطبيق (splash افتراضيًا).
  /// الاختبارات بت-pass شاشة الدخول هنا عشان تتجاوز شاشات البداية.
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bazar App',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[_DismissKeyboardObserver()],
      // سكيلر واحد لكل التطبيق: لو الشاشة مش 375 x 812 بتفضل نفس النسب
      // ونفس إحداثيات Figma من غير أي ضغط.
      builder: (BuildContext context, Widget? child) =>
          FixedDesignScaler(child: child ?? const SizedBox.shrink()),
      theme: ThemeData(
        fontFamily: AppText.family,
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        splashFactory: InkSparkle.splashFactory,
      ),
      home: home ?? const SplashScreen(),
    );
  }
}
