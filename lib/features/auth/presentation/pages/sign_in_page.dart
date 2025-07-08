import 'package:coursezy/features/auth/domain/user_entity.dart';
import 'package:coursezy/features/auth/presentation/validators/auth_validators.dart';
import 'package:coursezy/generated/l10n.dart';
import 'package:coursezy/router.dart';
import 'package:coursezy/shared/styles/colors.dart';
import 'package:coursezy/shared/styles/text.dart';
import 'package:coursezy/shared/widgets/custom_button.dart';
import 'package:coursezy/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var finalStep = false;
  var _isLoading = false;

  void _continueStep1() {
    if (_formKey.currentState!.validate() == true) {
      setState(() {
        finalStep = true;
      });
    }
  }

  void _continueStep2() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text;
      final password = _passwordController.text;
      await ref.read(authProvider.notifier).create(email, password);
    }
  }

  bool _obscurePassword = true;

  void _toggleObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _providerValidation() {
    ref.listen<AsyncValue<UserEntity?>>(authProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            // Navigate to home page if user is logged in
            router.push('/home');
          }
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _providerValidation();

    return Scaffold(
      backgroundColor: AppColor.backgroundPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          !finalStep ? S.of(context).newAccount : S.of(context).newPassword,
          style: TextStyles.gilroyBold,
        ),
        backgroundColor: AppColor.backgroundPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.bluePrimary),
          onPressed: () {
            if (!finalStep) {
              if (router.canPop()) {
                router.pop();
              } else {
                setState(() {
                  finalStep = false;
                  _emailController.clear();
                  _passwordController.clear();
                });
                router.push('/home');
              }
            } else {
              setState(() {
                finalStep = false;
                _passwordController.clear();
              });
              router.pushReplacement('/sign-in');
            }
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 280,
                  alignment: Alignment.topCenter,
                  child: Text(
                    !finalStep
                        ? S.of(context).newAccountTitle
                        : S.of(context).newPasswordTitle,
                    style: TextStyles.gilroyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Card(
                      color: AppColor.white,
                      elevation: 0,
                      shadowColor: AppColor.backgroundPrimary,
                      child: Column(
                        children: [
                          !finalStep
                              ? CustomTextField(
                                controller: _emailController,
                                label: S.of(context).email,
                                validator: validateEmail,
                              )
                              : CustomTextField(
                                controller: _passwordController,
                                suffixIcon: GestureDetector(
                                  onTap: () => _toggleObscure(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      _obscurePassword
                                          ? S.of(context).show.toUpperCase()
                                          : S.of(context).hide.toUpperCase(),
                                      style: TextStyles.gilroyBoldAlpha,
                                    ),
                                  ),
                                ),
                                label: S.of(context).password,
                                obscureText: _obscurePassword,
                                validator: validatePassword,
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    Text(
                      S.of(context).hasAccount,
                      style: TextStyles.gilroyRegular,
                    ),
                    GestureDetector(
                      onTap: () => router.push('/login'),
                      child: Text(
                        S.of(context).login.toUpperCase(),
                        style: TextStyles.gilroyBold16.copyWith(
                          color: AppColor.bluePrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    CustomButton(
                      label: S.of(context).continueBtn,
                      onPressed: !finalStep ? _continueStep1 : _continueStep2,
                      showIcon: true,
                      isLoading: _isLoading,
                      enable: !_isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
