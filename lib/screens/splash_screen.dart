import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';
import 'onboarding_screen.dart';

/// شاشة البداية (Splash) — إطار Figma رقم 1، مقاس 375×812 وخلفية `#54408C`.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.autoAdvance = true});

  /// لو ضعّفناها الشاشة هتقف مكانها من غير انتقال تلقائي،
  /// عشان الاختبارات تقدر تتحكم في الوقت بدل ما تستنى الـ Timer.
  final bool autoAdvance;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration _hold = Duration(milliseconds: 1800);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.autoAdvance) _timer = Timer(_hold, _advance);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _advance() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      SlidePageRoute<void>(page: const OnboardingScreen(page: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      background: AppColors.primary,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: AppMetrics.screenHeight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _advance,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                // لوجو باهت طالع من ناحية الشمال عشان الخلفية متبقاش فاضية.
                Positioned(
                  left: -30,
                  top: 495,
                  width: 315.86,
                  height: 316.61,
                  child: SvgPicture.asset(
                    'assets/svg/splash-watermark.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                // الرسم والاسم ركّبناهم بـ Stack عشان كل واحد ليه إحداثيات لوحدها.
                Positioned(
                  left: 80,
                  top: 376,
                  width: 158,
                  height: 44,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 12.62,
                        top: 3.03,
                        width: 37.85,
                        height: 37.94,
                        child: SvgPicture.asset(
                          'assets/svg/bazar-logo-mark.svg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Positioned(
                        left: 63.09,
                        top: 0,
                        child: Text('Bazar.', style: AppText.logo),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
