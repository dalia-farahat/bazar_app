import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// حقل كتابة موسوم من التصميم: لابل فوقه وخلفية رمادية فاتحة،
/// ولما الحقل ياخد focus بيظهر له حد بنفسجي جوّا الإطار.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.onSubmitted,
    this.onChanged,
    this.showVisibilityToggle = false,
    this.contentPadding,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  /// بيظهر زرار عين لإخفاء/إظهار الباسورد.
  final bool showVisibilityToggle;
  final EdgeInsets? contentPadding;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  late bool _obscured = widget.obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_sync);
  }

  /// نعيد البناء مع كل تغيير في focus عشان الحد البنفسجي يتحدث على طول.
  /// لو خزّنّا اللون في field كان هيفضل قديم ومحدش هيحدّثه.
  void _sync() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_sync);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSuffix = widget.showVisibilityToggle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // ياخد عرض الـparent اللي فوقه بدل ما نجمّده على 327.
          width: double.infinity,
          height: 20,
          child: Text(widget.label, style: AppText.body14Medium),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: AppMetrics.fieldHeight,
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(AppMetrics.fieldRadius),
            border: Border.all(
              color: _focusNode.hasFocus
                  ? AppColors.primary
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: _obscured,
            obscuringCharacter: '\u25CF',
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            autofillHints: widget.autofillHints,
            onSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            cursorColor: AppColors.primary,
            style: AppText.body16Medium.copyWith(height: 24 / 16),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              // الحد مرسوم جوّا الإطار 1px، فـ padding الـ16 في التصميم
              // بيتحسب من برّا الإطار: 16 - 1 = 15.
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.fromLTRB(15, 12, 16, 12),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: widget.hint,
              hintStyle: AppText.body16.copyWith(color: AppColors.gray400),
              suffixIcon: hasSuffix
                  ? Transform.translate(
                      // التصميم يبعد الزرار 18px عن الحافة، والـdecorator
                      // حاططه 7px بره زيادة، فنرجّعه جوّا من غير ما نحرّك الـlayout.
                      offset: const Offset(-7, 0),
                      child: IconButton(
                        onPressed: () => setState(() => _obscured = !_obscured),
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 24,
                          minHeight: 24,
                        ),
                        icon: Icon(
                          _obscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 24,
                          color: AppColors.gray400,
                        ),
                      ),
                    )
                  : null,
              suffixIconConstraints: hasSuffix
                  ? const BoxConstraints(minWidth: 24, minHeight: 24)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
