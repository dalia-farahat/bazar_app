import 'package:flutter/material.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/numeric_keypad.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_scaffold.dart';
import 'verification_phone_screen.dart';

/// شاشة إدخال رقم الموبايل — إطار Figma 2.6 بمقاس 375×812.
/// الرقم بيتعديله باللوحة الرقمية بس، عشان كده مفيش كيبورد نظامي بيفتح هنا.
class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  /// الأرقام الأولية اللي بتبدأ بيها الشاشة، مكتوبة كده `(+965) 123 435 7565`.
  static const String initialDigits = '9651234357565';

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

/// بيقسّم أرقام لحد 13 رقم كده: `(+CCC) XXX XXX XXXX`.
String formatPhoneNumber(String digits) {
  if (digits.isEmpty) return '';
  final String country = digits.substring(
    0,
    digits.length < 3 ? digits.length : 3,
  );
  final StringBuffer out = StringBuffer('(+$country');
  if (digits.length >= 3) out.write(')');

  final String rest = digits.length > 3 ? digits.substring(3) : '';
  const List<int> sizes = <int>[3, 3, 4];
  int index = 0;
  int group = 0;
  while (index < rest.length && group < sizes.length) {
    final int remaining = rest.length - index;
    final int take = remaining < sizes[group] ? remaining : sizes[group];
    out
      ..write(' ')
      ..write(rest.substring(index, index + take));
    index += take;
    group += 1;
  }
  return out.toString();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  late String _digits = PhoneNumberScreen.initialDigits;

  void _onKey(String key) {
    if (key == 'back') {
      if (_digits.isNotEmpty) {
        setState(() => _digits = _digits.substring(0, _digits.length - 1));
      }
    } else if (key != '.' && _digits.length < 13) {
      setState(() => _digits += key);
    }
  }

  void _continue() {
    Navigator.of(context).push(
      SlidePageRoute<void>(
        page: VerificationPhoneScreen(phone: formatPhoneNumber(_digits)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String value = formatPhoneNumber(_digits);

    return ScreenScaffold(
      showBack: true,
      bottom: NumericKeypad(onKey: _onKey),
      bottomInset: NumericKeypad.height,
      children: <Widget>[
        const SizedBox(height: 116),
        Gutter(
          dy: 1,
          child: Text(
            'Phone Number',
            style: AppText.h3,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        const Gutter(
          dy: -1,
          child: Text(
            'Please enter your phone number, so we can more easily deliver '
            'your order',
            style: AppText.body16,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        const Gutter(child: Text('Phone Number', style: AppText.body14Medium)),
        const SizedBox(height: 6),
        Gutter(
          child: Container(
            width: AppMetrics.fieldWidth,
            height: AppMetrics.fieldHeight,
            padding: const EdgeInsets.only(left: 12, right: 16),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(AppMetrics.fieldRadius),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.phone, size: 24, color: AppColors.primary),
                const SizedBox(width: 16),
                Text(value, style: AppText.body16Medium),
              ],
            ),
          ),
        ),
        const SizedBox(height: 81),
        Gutter(
          child: PrimaryButton(label: 'Continue', onPressed: _continue),
        ),
      ],
    );
  }
}
