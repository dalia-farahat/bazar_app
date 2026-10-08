import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// شروط الباسورد الثلاثة اللي بتظهر تحت الحقل وهو متفتح.
/// كل سطر: أيقونة 16px عند x=24، ثم مسافة 12px، ثم نص عند x=52،
/// وارتفاع السطر 20px والفجوة بينهم 8px.
class PasswordRules extends StatelessWidget {
  const PasswordRules({
    super.key,
    required this.rules,
    required this.satisfied,
  });

  final List<String> rules;
  final List<bool> satisfied;

  @override
  Widget build(BuildContext context) {
    assert(rules.length == satisfied.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < rules.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == rules.length - 1 ? 0 : 8),
            child: SizedBox(
              height: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    satisfied[i] ? Icons.check : Icons.close,
                    size: 16,
                    color: satisfied[i] ? AppColors.primary300 : AppColors.red,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    rules[i],
                    // التصميم بيكتب الكلام ده بتباعد أحرف أوسع شوية،
                    // فبنزود letterSpacing عشان الكلمات تقف على نفس
                    // عمود التصميم.
                    style: AppText.body14.copyWith(letterSpacing: 0.35),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
