import 'package:flutter/material.dart';

import '../app_route.dart';
import 'phone_number_screen.dart';
import 'verification_screen.dart';

/// شاشة كود التحقق بالإيميل — إطار Figma 2.5.
/// بنكرّر الإيميل اللي اتكتب في شاشة التسجيل، ولو مفيش إيميل نستخدم الافتراضي.
class VerificationEmailScreen extends StatelessWidget {
  const VerificationEmailScreen({super.key, this.email});

  static const String _demoEmail = 'Johndoe@gmail.com';

  final String? email;

  @override
  Widget build(BuildContext context) {
    final String address = (email == null || email!.isEmpty)
        ? _demoEmail
        : email!;

    return VerificationScreen(
      title: 'Verification Email',
      subtitleLead: 'Please enter the code we just sent to email ',
      subtitleTail: address,
      onContinue: () {
        Navigator.of(
          context,
        ).push(SlidePageRoute<void>(page: const PhoneNumberScreen()));
      },
    );
  }
}
