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
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text;
      final password = _passwordController.text;
      ref.read(authProvider.notifier).login(email, password);
    }
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
        title: Text(S.of(context).login, style: TextStyles.gilroyBold),
        backgroundColor: AppColor.backgroundPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.bluePrimary),
          onPressed: () {
            router.pop();
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
                  width: 250,
                  alignment: Alignment.topCenter,
                  child: Text(
                    S.of(context).loginTitle,
                    style: TextStyles.gilroyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 140),
                    Card(
                      color: AppColor.white,
                      elevation: 0,
                      shadowColor: AppColor.backgroundPrimary,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            label: S.of(context).email,
                            validator: validateEmail,
                          ),
                          Divider(color: AppColor.backgroundPrimary, height: 1),
                          CustomTextField(
                            controller: _passwordController,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // Handle forgot password action
                                print('Forgot password tapped');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  S.of(context).forgot.toUpperCase(),
                                  style: TextStyles.gilroyBoldAlpha,
                                ),
                              ),
                            ),
                            label: S.of(context).password,
                            obscureText: true,
                            validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    CustomButton(
                      label: S.of(context).continueBtn,
                      onPressed: _login,
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
