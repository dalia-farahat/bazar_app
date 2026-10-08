import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// الكيبورد الرقمي البنفسجي المثبت في أسفل شاشات التحقق.
/// التصميم: كتلة 375 x 357، أربع صفوف كل واحد 80px، وثلاث أعمدة 125px.
/// مفيش شريط أسفل هنا لأن التطبيق بيرسم محتواه هو بس.
class NumericKeypad extends StatelessWidget {
  const NumericKeypad({super.key, required this.onKey});

  /// بيرسل '0' لـ'9' أو '.' أو 'back'.
  final ValueChanged<String> onKey;

  /// ارتفاع الكتلة البنفسجية؛ الشاشات بتعديه لـbottomInset
  /// عشان عمود المحتوى يتحرّك ويوصّل تحتها.
  static const double height = 357;

  static const List<String> _keys = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    'back',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.primary,
      child: Stack(
        children: <Widget>[
          for (int row = 0; row < 4; row++)
            Positioned(
              left: 0,
              top: 8 + row * 80.0,
              right: 0,
              height: 80,
              child: Row(
                children: <Widget>[
                  for (int col = 0; col < 3; col++)
                    Expanded(
                      child: _KeypadKey(
                        label: _keys[row * 3 + col],
                        onTap: () => onKey(_keys[row * 3 + col]),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _KeypadKey extends StatelessWidget {
  const _KeypadKey({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: label == 'back'
            ? const Icon(
                Icons.backspace_outlined,
                size: 28,
                color: AppColors.gray50,
              )
            : Text(label, style: AppText.h3.copyWith(color: AppColors.gray50)),
      ),
    );
  }
}
