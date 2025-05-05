import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Center(
        child: authState.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: ${error.toString()}'),
              ElevatedButton(
                onPressed: () => _signIn(ref, context),
                child: const Text('Retry'),
              ),
            ],
          ),
          data: (user) => user == null
              ? ElevatedButton(
            onPressed: () => _signIn(ref, context),
            child: const Text('Sign in with Google'),
          )
              : const Text("already signed in")

        ),
      )
    );
  }

  Future<void> _signIn(WidgetRef ref,BuildContext context) async {
    try {
      await ref.read(authServiceProvider).signInWithGoogle();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: ${e.toString()}')),
      );
    }
  }
}