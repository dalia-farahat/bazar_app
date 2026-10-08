import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_scaffold.dart';
import 'sign_in_screen.dart';

/// صفحة من كاروسيل الأونبوردنج — إطارات Figma من 1.1 لـ 1.3.
/// التلات إطارات شكلهم واحد، فبنشارك نفس الـ widget ونغيّر الداتا بس.
class _OnboardingPage {
  const _OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.art,
    required this.cta,
    required this.titleX,
    required this.titleWidth,
    required this.subtitleX,
    required this.subtitleWidth,
  });

  final String title;
  final String subtitle;

  /// ملف الرسم SVG مصدَّر من نفس الـ frame.
  final String art;

  /// نص الزر الأساسي — في آخر صفحة بيبقى "Get Started".
  final String cta;

  /// مكان أول نقطة في نص العنوان وعرضه (y = 442) حسب التصميم.
  final double titleX;
  final double titleWidth;

  /// مكان أول نقطة في النص الفرعي وعرضه (y = 518) حسب التصميم.
  final double subtitleX;
  final double subtitleWidth;
}

/// صفحات الكاروسيل بالترتيب حسب تصميم Figma.
/// المسافة في أول سطر من أول نص مش غلطة نايمة — موجودة في التصميم عشان السطر يبدأ من مكانه الصح.
const List<_OnboardingPage> _kPages = <_OnboardingPage>[
  _OnboardingPage(
    title: 'Now reading books will be easier',
    subtitle:
        ' Discover new worlds, join a vibrant reading community. Start your '
        'reading adventure effortlessly with us.',
    art: 'assets/svg/onboarding-reading.svg',
    cta: 'Next',
    titleX: 66,
    titleWidth: 243,
    subtitleX: 41,
    subtitleWidth: 292,
  ),
  _OnboardingPage(
    title: 'Your Bookish Soulmate Awaits',
    subtitle:
        'Let us be your guide to the perfect read. Discover books tailored '
        'to your tastes for a truly rewarding experience.',
    art: 'assets/svg/onboarding-soulmate.svg',
    cta: 'Next',
    titleX: 42,
    titleWidth: 291,
    subtitleX: 45,
    subtitleWidth: 285,
  ),
  _OnboardingPage(
    title: 'Start Your Adventure',
    subtitle:
        "Ready to embark on a quest for inspiration and knowledge? Your "
        "adventure begins now. Let's go!",
    art: 'assets/svg/onboarding-adventure.svg',
    cta: 'Get Started',
    titleX: 66,
    titleWidth: 243,
    subtitleX: 66,
    subtitleWidth: 243,
  ),
];

/// شاشة كاروسيل الأونبوردنج (إطارات 1.1 – 1.3 من التصميم).
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.page})
    : assert(page >= 0 && page < 3);

  /// رقم الصفحة في الكاروسيل، بيبدأ من صفر.
  final int page;

  void _signIn(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      SlidePageRoute<void>(page: const SignInScreen()),
      (Route<dynamic> route) => false,
    );
  }

  /// الزر الأساسي في أي صفحة بيوديك للصفحة بعده،
  /// وفي آخر صفحة (اللي مكتوب فيها "Get Started") بيخرج من الكاروسيل ويفتح Sign in.
  void _primary(BuildContext context) {
    if (page + 1 >= _kPages.length) {
      _signIn(context);
      return;
    }
    Navigator.of(
      context,
    ).push(SlidePageRoute<void>(page: OnboardingScreen(page: page + 1)));
  }

  @override
  Widget build(BuildContext context) {
    final _OnboardingPage data = _kPages[page];

    return ScreenScaffold(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: AppMetrics.screenHeight,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // زرار Skip نص عادي من غير خلفية، مكانه (24, 60) حسب التصميم.
              Positioned(
                left: 24,
                top: 60,
                width: 60,
                height: 36,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _signIn(context),
                  child: Center(child: Text('Skip', style: AppText.skip)),
                ),
              ),
              // إطار الرسم 320×320 في (27, 109) حسب التصميم.
              Positioned(
                left: 27,
                right: 28,
                top: 109,
                height: 320,
                child: SvgPicture.asset(data.art, fit: BoxFit.contain),
              ),
              Positioned(
                left: data.titleX,
                right: AppMetrics.screenWidth - data.titleX - data.titleWidth,
                top: 442,
                child: Text(
                  data.title,
                  style: AppText.h3,
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                left: data.subtitleX,
                right:
                    AppMetrics.screenWidth -
                    data.subtitleX -
                    data.subtitleWidth,
                top: 518,
                child: Text(
                  data.subtitle,
                  style: AppText.body16,
                  textAlign: TextAlign.center,
                ),
              ),
              // النقطة النشطة 8px والتانية 4px وبينهم 4px (حسب التصميم).
              // حطيناهم في Row بالتوسيط عشان يفضلوا في نص الشاشة حتى لو العرض اتغير.
              Positioned(
                left: 176,
                right: 175,
                top: 619,
                height: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < _kPages.length; i++) ...<Widget>[
                      if (i > 0) const SizedBox(width: 4),
                      _PageDot(active: i == page),
                    ],
                  ],
                ),
              ),
              Positioned(
                left: AppMetrics.gutter,
                right: AppMetrics.gutter,
                top: 659,
                child: PrimaryButton(
                  label: data.cta,
                  height: 56,
                  radius: 12,
                  onPressed: () => _primary(context),
                ),
              ),
              Positioned(
                left: AppMetrics.gutter,
                right: AppMetrics.gutter,
                top: 723,
                child: PrimaryButton(
                  label: 'Sign in',
                  height: 56,
                  radius: 12,
                  background: AppColors.primary50,
                  labelStyle: AppText.h6.copyWith(color: AppColors.primary),
                  onPressed: () => _signIn(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PageDot extends StatelessWidget {
  const _PageDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final double size = active ? 8 : 4;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.gray200,
        shape: BoxShape.circle,
      ),
    );
  }
}
