import 'package:coursezy/features/auth/domain/user_entity.dart';
import 'package:coursezy/generated/l10n.dart';
import 'package:coursezy/router.dart';
import 'package:coursezy/shared/styles/colors.dart';
import 'package:coursezy/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _providerValidation() {
    ref.listen<AsyncValue<UserEntity?>>(authProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user == null) {
            router.pushReplacement('/login');
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
    final user = ref.watch(authProvider).value;
    _providerValidation();

    return Scaffold(
      backgroundColor: AppColor.backgroundPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(S.of(context).home, style: TextStyles.gilroyBold),
        backgroundColor: AppColor.backgroundPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).greeting(user?.email ?? '')),
              ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                child: Text(S.of(context).logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
