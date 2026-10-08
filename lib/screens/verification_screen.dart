import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/numeric_keypad.dart';
import '../widgets/otp_input.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_scaffold.dart';

/// شاشة كود التحقق — إطارات Figma 2.5 (إيميل) و 2.7 (موبايل).
/// اللوحة الرقمية مش باينة في البداية: تفتح بالدوس على خانات الكود وتتقفل بالدوس بره.
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
    required this.title,
    required this.subtitleLead,
    required this.subtitleTail,
    this.initialCode = '',
    required this.onContinue,
  });

  final String title;
  final String subtitleLead;
  final String subtitleTail;

  /// بتبدأ فاضية عمدًا عشان الخانات تفضل نظيفة والكيرسور بس هو الظاهر.
  final String initialCode;

  final VoidCallback onContinue;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late String _code = widget.initialCode;

  /// اللوحة بتبدأ مخفية وتتابع الخانات: تتفتح بالدوس عليها وتتقفل بدوس في أي مكان تاني.
  bool _keypadOpen = false;

  void _onKey(String key) {
    if (key == 'back') {
      if (_code.isNotEmpty) {
        setState(() => _code = _code.substring(0, _code.length - 1));
      }
    } else if (key != '.' && _code.length < 4) {
      setState(() => _code += key);
    }
  }

  @override
  Widget build(BuildContext context) {
    // أي دوس مش متمسك من عنصر أصغر (الخانات أو اللوحة) يقع هنا ويقفل اللوحة.
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_keypadOpen) {
          setState(() => _keypadOpen = false);
        }
      },
      child: ScreenScaffold(
        showBack: true,
        bottom: _keypadOpen ? NumericKeypad(onKey: _onKey) : null,
        bottomInset: NumericKeypad.height,
        children: <Widget>[
          const SizedBox(height: 116),
          Gutter(
            dy: 1,
            child: Text(
              widget.title,
              style: AppText.h3,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Gutter(
            dy: -1,
            child: Text.rich(
              TextSpan(
                style: AppText.body16.copyWith(color: AppColors.gray500),
                children: <InlineSpan>[
                  TextSpan(text: widget.subtitleLead),
                  TextSpan(
                    text: widget.subtitleTail,
                    style: const TextStyle(color: AppColors.gray900),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!_keypadOpen) {
                setState(() => _keypadOpen = true);
              }
            },
            child: OtpInput(value: _code),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text.rich(
              TextSpan(
                style: AppText.body14Semibold.copyWith(
                  color: AppColors.gray500,
                ),
                children: const <InlineSpan>[
                  TextSpan(text: "If you didn't receive a code? "),
                  TextSpan(
                    text: 'Resend',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 43),
          Gutter(
            child: PrimaryButton(
              label: 'Continue',
              onPressed: widget.onContinue,
            ),
          ),
        ],
      ),
    );
  }
}
