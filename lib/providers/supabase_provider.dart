import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_provider.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService(ref.read(supabaseProvider));
});

final userDetailsProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final authState = ref.watch(authStateProvider);

  final uid = authState.value?.uid;
  if (uid == null) return null;
  final response = await Supabase.instance.client
      .from('user_details')
      .select()
      .eq('user_id', uid)
      .maybeSingle();

  return response;
});


class DatabaseService {
  final SupabaseClient _supabase;

  DatabaseService(this._supabase);

  Future<void> saveUserDetails({
    required String userId,
    required String address,
    required String phone,
    required String age,
    String? notes,
  }) async {
    await _supabase.from('user_details').upsert({
      'user_id': userId,
      'address': address,
      'phone': phone,
      'age': age,
      'notes': notes,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id');
  }

  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    final data = await _supabase
        .from('user_details')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    print(Supabase.instance.client.from('user_details').select('age'));
    print("Fetching user details for: ${userId}");


    return data;
  }
  Future<void> deleteUserDetails(String? userId) async {
    try {
      await _supabase
              .from('user_details')
              .delete()
              .eq('user_id', userId ?? "");
    } catch (e) {
      print(e);
    }
  }
}
