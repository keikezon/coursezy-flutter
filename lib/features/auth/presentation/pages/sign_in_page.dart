import 'package:coursezy/features/auth/presentation/validators/auth_validators.dart';
import 'package:coursezy/generated/l10n.dart';
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

  void _continue() {
    print("teste");
    final email = _emailController.text;
    final password = _passwordController.text;
    print(_formKey.currentState!.validate());
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).create(email, password);
    } else {
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).fillAllFields)));
    }
  }

  bool _obscurePassword = true;

  void _toggleObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColor.backgroundPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: authState.when(
          data:
              (user) => Text(
                user?.email == null
                    ? S.of(context).newAccount
                    : S.of(context).newPassword,
                style: TextStyles.gilroyBold,
              ),
          loading: () => const SizedBox.shrink(),
          error:
              (e, _) =>
                  Text(S.of(context).newAccount, style: TextStyles.gilroyBold),
        ),
        backgroundColor: AppColor.backgroundPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.bluePrimary),
          onPressed: () {
            // handle the press
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          child: authState.when(
            data: (user) {
              return Column(
                children: [
                  Center(
                    child: Container(
                      width: 280,
                      alignment: Alignment.topCenter,
                      child: Text(
                        user?.email == null
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
                              user?.email == null
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
                                              : S
                                                  .of(context)
                                                  .hide
                                                  .toUpperCase(),
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
                          onTap: () => context.push('/login'),
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
                          onPressed: () => _continue,
                          showIcon: true,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Error: $e'),
          ),
        ),
      ),
    );
  }
}
