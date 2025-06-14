import 'package:flutter/material.dart';
import 'package:untitled19/data/repositories/auth_repositories.dart';
import 'package:untitled19/data/service/service_locator.dart';
import 'package:untitled19/presentation/authentication/login_screen.dart';

import '../../router/app_router.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.exit_to_app, color: Colors.red),
      label: const Text('Log Out', style: TextStyle(color: Colors.red)),
      onPressed: () async {
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        if (confirm == true) {
         await getIt<AuthRepository>().singOut();
          getIt<AppRouter>().pushAndRemoveUntil(const LoginView());
        }
      },
    );
  }
}
