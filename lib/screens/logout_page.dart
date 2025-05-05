import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/supabase_provider.dart';

class LogoutPage extends ConsumerWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Logut Page"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  try {
                    await ref.read(authServiceProvider).signOut();
                    // Clear Supabase session if needed
                    await ref.read(supabaseProvider).auth.signOut();
                    Navigator.pop(context);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Logout failed: ${e.toString()}')),
                      );
                    }
                  }
                },
                child: Text("Click to Logout"))
          ],
        ),
      ),
    );
  }
}
