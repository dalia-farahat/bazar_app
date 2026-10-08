import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_scaffold.dart';
import 'sign_in_screen.dart';

/// شاشة نجاح التسجيل — إطار Figma 2.8 بمقاس 375×812.
/// مفيش زرار رجوع في الإطار ده لأن المستخدم خلّص التسجيل خلاص.
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  void _getStarted(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      SlidePageRoute<void>(page: const SignInScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      children: <Widget>[
        const SizedBox(height: 253),
        Center(
          child: SizedBox(
            width: 160,
            height: 91,
            child: SvgPicture.asset('assets/svg/gift.svg', fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 40),
        const Gutter(
          dy: 1,
          child: Text(
            'Congratulation!',
            style: AppText.h3,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        const Gutter(
          dy: -1,
          child: Text(
            'your account is complete, please enjoy the best menu from us.',
            style: AppText.body16,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        Gutter(
          child: PrimaryButton(
            label: 'Get Started',
            onPressed: () => _getStarted(context),
          ),
        ),
      ],
    );
  }
}
