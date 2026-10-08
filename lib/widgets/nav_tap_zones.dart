import 'package:flutter/material.dart';

/// أماكن لمس شفافة فوق التبويبات الثلاثة في الشريط السفلي.
/// الشريط مرسوم كصورة واحدة ثابتة، فبنحط مناطق اللمس في طبقة فوقها:
/// 3 مناطق متساوية 125px وسط كل تبويب، وnull تعني التبويب الحالي.
class NavTapZones extends StatelessWidget {
  const NavTapZones({super.key, this.onHome, this.onCategory, this.onProfile});

  final VoidCallback? onHome;
  final VoidCallback? onCategory;
  final VoidCallback? onProfile;

  @override
  Widget build(BuildContext context) {
    Widget zone(double left, VoidCallback? onTap) => Positioned(
      left: left,
      width: 125,
      top: 0,
      bottom: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: const SizedBox.expand(),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        zone(0, onHome),
        zone(125, onCategory),
        zone(250, onProfile),
      ],
    );
  }
}
