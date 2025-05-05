import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_ai_24/providers/auth_provider.dart';
import 'package:top_ai_24/screens/user_details_page.dart';
import 'package:top_ai_24/screens/login_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://lvmudlkxcwguypeicecd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx2bXVkbGt4Y3dndXlwZWljZWNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYzNjYwNzIsImV4cCI6MjA2MTk0MjA3Mn0.v4S8Yh-mDE_lDYJAy2cGI_xAFnWCNJBedfagXgyqqOc',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      home: authState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => LoginPage(),
        data: (user) => user != null ? const UserDetails() : const LoginPage(),
      ),
    );
  }
}
