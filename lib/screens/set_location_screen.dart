import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/screen_scaffold.dart';

/// شاشة "Set Location" — نموذج إدخال العنوان.
/// الشاشة أطول من الشاشة العادية (909) فبتلف، وفيها 8 خانات متساوية المسافة + زر تأكيد.
class SetLocationScreen extends StatelessWidget {
  const SetLocationScreen({super.key});

  /// أسماء الخانات الثمانية من فوق لتحت.
  static const List<String> fields = <String>[
    'Governorate',
    'City',
    'Block',
    'Street name /number',
    'Building name/number',
    'Floor (option)',
    'Flat(option)',
    'Avenue (option)',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 909,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // الهيدر
              const Positioned(
                left: 144,
                right: 144,
                top: 66,
                child: Text(
                  'Location',
                  textAlign: TextAlign.center,
                  style: AppText.appBarTitle,
                ),
              ),
              Positioned(
                left: 24,
                top: 68,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Image.asset(
                    'assets/figma/loc-icon-back.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Positioned(
                right: 24,
                top: 68,
                child: Image.asset(
                  'assets/figma/loc-icon-gps.png',
                  width: 24,
                  height: 24,
                ),
              ),

              // الخانات
              for (int i = 0; i < fields.length; i++)
                _Field(top: 116.0 + 90 * i, label: fields[i]),

              // زر التأكيد
              Positioned(
                left: 24,
                right: 24,
                top: 836,
                height: 48,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                    ),
                    child: const Text('Confirmation', style: AppText.h6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// صف واحد في النموذج: Label فوق صندوق فيه النص.
class _Field extends StatelessWidget {
  const _Field({required this.top, required this.label});

  final double top;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      top: top,
      height: 74,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            width: 327,
            child: Text(label, style: AppText.cardTitle),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 26,
            height: 48,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    label,
                    style: AppText.body16.copyWith(color: AppColors.gray400),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
