import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/supabase_provider.dart';

class EraseDataPage extends ConsumerWidget {
  const EraseDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseServiceProvider);
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Erase Data Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  // try {

                    await database.deleteUserDetails(authState.value?.uid);

                    Navigator.pop(context);
                  // } catch (e) {
                  //   if (context.mounted) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       SnackBar(
                  //           content: Text('Logout failed: ${e.toString()}')),
                  //     );
                  //   }
                  // }
                },
                child: Text("Click to Delete your data")),
          ],
        ),
      ),
    );
  }
}
