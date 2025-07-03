import 'package:coursezy/generated/l10n.dart';
import 'package:coursezy/shared/styles/colors.dart';
import 'package:coursezy/shared/styles/text.dart';
import 'package:coursezy/shared/widgets/custom_button.dart';
import 'package:coursezy/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;
    ref.read(authProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColor.backgroundPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).login, style: TextStyles.gilroyBold),
        backgroundColor: AppColor.backgroundPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.bluePrimary),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          child: authState.when(
            data: (user) {
              if (user != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).greeting(user.email)),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(authProvider.notifier).logout();
                      },
                      child: Text(S.of(context).logout),
                    ),
                  ],
                );
              }
              return Column(
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
                  Column(
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
                            ),
                            Divider(
                              color: AppColor.backgroundPrimary,
                              height: 1,
                            ),
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                      CustomButton(
                        label: S.of(context).continueBtn,
                        onPressed: _login,
                        showIcon: true,
                      ),
                    ],
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
