import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// زرار الرجوع 40 x 40 من التصميم، مكانه (16, 60).
/// اسمه AppBackButton عشان ما يتضارمش مع material.BackButton.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap, this.color = AppColors.gray900});

  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Semantics(
        button: true,
        label: 'Back',
        child: InkWell(
          onTap: onTap ?? () => Navigator.of(context).maybePop(),
          borderRadius: BorderRadius.circular(12),
          child: CustomPaint(
            painter: _ArrowLeftPainter(color),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

/// سهم شمال مفرّغ: خط أفقي بسهم على شماله، بنفس شكل أيقونة التصميم
/// جوّا إطار 24 x 24 المركزي في زرار الـ40 x 40.
class _ArrowLeftPainter extends CustomPainter {
  _ArrowLeftPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // إطار الأيقونة 24 x 24 في نص الزرار 40 x 40.
    final double dx = (size.width - 24) / 2;
    final double dy = (size.height - 24) / 2;
    canvas.translate(dx, dy);

    final Path path = Path()
      ..moveTo(19.83, 11.6)
      ..lineTo(3, 11.6)
      ..lineTo(9.07, 5.53)
      ..moveTo(3, 11.6)
      ..lineTo(9.07, 17.67);

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ArrowLeftPainter oldDelegate) =>
      oldDelegate.color != color;
}
