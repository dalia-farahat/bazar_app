import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// بلوك نص عرضه 243px بيتقسم على سطرين وسط: الأول رمادي والتاني لينك بنفسجي.
class TermsText extends StatelessWidget {
  const TermsText({super.key, this.includeAnd = true});

  /// التصميم بيكتب "Terms and Data Policy." والحالة فاضية،
  /// و"Terms, Data Policy." بعد ما الباسورد يتكتب.
  final bool includeAnd;

  @override
  Widget build(BuildContext context) {
    final String link = includeAnd
        ? 'Terms and Data Policy.'
        : 'Terms, Data Policy.';

    return SizedBox(
      width: 243,
      child: Text.rich(
        TextSpan(
          style: AppText.body14Medium.copyWith(color: AppColors.gray500),
          children: <InlineSpan>[
            const TextSpan(text: 'By clicking Register, you agree to our '),
            TextSpan(
              text: link,
              style: const TextStyle(color: AppColors.primary),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
