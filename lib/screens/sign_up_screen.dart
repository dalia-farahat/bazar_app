import 'package:flutter/material.dart';

import '../app_route.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/password_rules.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_scaffold.dart';
import '../widgets/terms_text.dart';
import 'verification_email_screen.dart';

/// شاشة التسجيل — إطارات Figma من 2.2 لـ 2.4 بمقاس 375×812.
/// الفرق بينهم بس هو قواعد الباسورد: بتظهر لما الحقل يتفعل ويتسجّل فيه كلام.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const List<String> _ruleLabels = <String>[
    'Minimum 8 characters',
    'Atleast 1 number (1-9)',
    'Atleast lowercase or uppercase letters',
  ];

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _passwordFocus.removeListener(_syncRules);
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  /// لما الـ focus يتغيّر لازم الشاشة كلها تتعاد عشان القواعد تظهر أو تختفي.
  void _syncRules() => setState(() {});

  bool get _hasMinLength => _password.text.length >= 8;
  bool get _hasNumber => _password.text.contains(RegExp(r'[0-9]'));
  bool get _hasLetter => _password.text.contains(RegExp(r'[A-Za-z]'));

  @override
  void initState() {
    super.initState();
    _passwordFocus.addListener(_syncRules);
  }

  /// القواعد دي بتاعت حقل الباسورد المفعّل بس: frame 2.4 يبيّنه والباقي لأ.
  bool get _showRules => _passwordFocus.hasFocus && _password.text.isNotEmpty;

  /// في إطار واحد بس (الباسورد مكتوب والحقل ساكن) المحتوى مزاح pixel لليمين
  /// عن باقي الإطارات حسب التصميم، فبنرجّع 1 عشان الـ scaffold يزحزحه.
  double get _frameDx =>
      (_password.text.isNotEmpty && !_passwordFocus.hasFocus) ? 1 : 0;

  void _register() {
    Navigator.of(context).push(
      SlidePageRoute<void>(page: VerificationEmailScreen(email: _email.text)),
    );
  }

  void _goSignIn() => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    final List<bool> states = <bool>[_hasMinLength, _hasNumber, _hasLetter];

    return ScreenScaffold(
      showBack: true,
      contentDx: _frameDx,
      footer: Center(child: TermsText(includeAnd: _password.text.isEmpty)),
      children: <Widget>[
        const SizedBox(height: 116),
        const Gutter(dy: 1, child: Text('Sign Up', style: AppText.h3)),
        const SizedBox(height: 8),
        const Gutter(
          dy: -1,
          child: Text(
            'Create account and choose favorite menu',
            style: AppText.body16,
          ),
        ),
        const SizedBox(height: 24),
        Gutter(
          child: AppTextField(
            label: 'Name',
            hint: 'Your name',
            controller: _name,
            focusNode: _nameFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _emailFocus.requestFocus(),
          ),
        ),
        const SizedBox(height: 16),
        Gutter(
          child: AppTextField(
            label: 'Email',
            hint: 'Your email',
            controller: _email,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const <String>[AutofillHints.email],
            onSubmitted: (_) => _passwordFocus.requestFocus(),
          ),
        ),
        const SizedBox(height: 16),
        Gutter(
          child: AppTextField(
            label: 'Password',
            hint: 'Your password',
            controller: _password,
            focusNode: _passwordFocus,
            obscureText: true,
            showVisibilityToggle: true,
            textInputAction: TextInputAction.done,
            autofillHints: const <String>[AutofillHints.newPassword],
            onChanged: (_) => setState(() {}),
          ),
        ),
        if (_showRules) ...<Widget>[
          const SizedBox(height: 16),
          Gutter(
            child: PasswordRules(rules: _ruleLabels, satisfied: states),
          ),
        ],
        const SizedBox(height: 24),
        Gutter(
          child: PrimaryButton(label: 'Register', onPressed: _register),
        ),
        const SizedBox(height: 24),
        Gutter(
          child: GestureDetector(
            onTap: _goSignIn,
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: SizedBox(
                width: 243,
                child: Text.rich(
                  TextSpan(
                    style: AppText.body16Medium.copyWith(
                      color: AppColors.gray500,
                    ),
                    children: const <InlineSpan>[
                      TextSpan(text: 'Have an account? '),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
