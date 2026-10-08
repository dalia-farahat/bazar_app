import 'package:flutter/material.dart';

import '../app_route.dart';
import 'success_screen.dart';
import 'verification_screen.dart';

/// شاشة كود التحقق بالموبايل — إطار Figma 2.7.
class VerificationPhoneScreen extends StatelessWidget {
  const VerificationPhoneScreen({super.key, this.phone});

  /// ده الرقم اللي ظاهر في إطار 2.7 من التصميم، بنستخدمه لو المستخدم مدخلش رقم.
  static const String _demoPhone = '(+20) 123477092 299';

  final String? phone;

  @override
  Widget build(BuildContext context) {
    final String number = (phone == null || phone!.isEmpty)
        ? _demoPhone
        : phone!;

    return VerificationScreen(
      title: 'Verification Phone',
      subtitleLead: 'Please enter the code we just sent to phone number  ',
      subtitleTail: number,
      onContinue: () {
        Navigator.of(
          context,
        ).push(SlidePageRoute<void>(page: const SuccessScreen()));
      },
    );
  }
}
