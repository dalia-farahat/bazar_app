import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// أربع صناديق كود التحقق 52 x 52.
/// الصناديق بتبدأ من x=59 وبينهم 16px، والمليانة بتبين رقم.
/// صندوق المؤشر بيبين علامة | وحد بنفسجي، والباقي من غير حد.
class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.value,
    this.length = 4,
    this.showCaret = true,
  });

  final String value;
  final int length;

  /// يرسم المؤشر والحد في الصندوق اللي بعد آخر رقم.
  final bool showCaret;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 59),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: AppMetrics.otpGap),
            _OtpBox(
              digit: i < value.length ? value[i] : null,
              focused: showCaret && i == value.length,
            ),
          ],
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({this.digit, required this.focused});

  final String? digit;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppMetrics.otpBox,
      height: AppMetrics.otpBox,
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(AppMetrics.otpRadius),
        border: focused ? Border.all(color: AppColors.primary, width: 1) : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (digit != null)
            Text(digit!, style: AppText.h3)
          else if (focused)
            const Text(
              '|',
              style: TextStyle(
                fontFamily: AppText.family,
                fontSize: 24,
                height: 32 / 24,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
