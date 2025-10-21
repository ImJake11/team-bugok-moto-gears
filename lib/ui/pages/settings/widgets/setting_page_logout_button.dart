import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/ui/widgets/snackbar.dart';
import 'package:team_bugok_business/utils/database/repositories/cache_repository.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';
import 'package:team_bugok_business/utils/provider/loading_provider.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

class SettingPageLogoutButton extends StatefulWidget {
  const SettingPageLogoutButton({super.key});

  @override
  State<SettingPageLogoutButton> createState() =>
      _SettingPageLogoutButtonState();
}

class _SettingPageLogoutButtonState extends State<SettingPageLogoutButton> {
  Future<void> _logout() async {
    final loading = context.read<LoadingProvider>();

    try {
      loading.showLoading("Logging out");
      await CacheRepository().logOut();
      await Future.delayed(Duration(seconds: 2));
      context.read<AuthProvider>().setUserAsLoggedOut();
      context.goNamed("auth-page");
    } catch (e, st) {
      print("Failed to logout ${e}");
      print(st);
      CustomSnackBar(
        message: "Failed to logout",
        context: context,
      ).show();
    } finally {
      if (mounted) {
        loading.closeLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<MyThemeProvider>();

    return GestureDetector(
      onTap: () {
        _logout();
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.primary,
          ),
          color: theme.primary.withAlpha(20),
        ),
        child: Center(
          child: Text(
            "Logout",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
