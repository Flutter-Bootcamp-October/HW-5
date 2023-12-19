import 'package:supabase/supabase.dart';

class SupaBaseIntegration {
  static late SupabaseClient subaInstance;
  get supabase {
    final supabase = SupabaseClient("https://xhxvkuomfbexjngzxmbw.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhoeHZrdW9tZmJleGpuZ3p4bWJ3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMTE5NzEyNCwiZXhwIjoyMDE2NzczMTI0fQ.xPOTWYHfv10IcLZwmvlC8ZKppfDli_Ui1GIpBqH_kdI");
    SupaBaseIntegration.subaInstance = supabase;
  }

  Future<UserResponse> getUserByToken({required String token}) async {
    final UserResponse user = await subaInstance.auth.getUser(token);
    return user;
  }

  Future<List<Map<String, dynamic>>> getFromTable(
      {required String tableName, required user}) async {
    return await subaInstance
        .from(tableName)
        .select()
        .eq('user_id', user.user!.id);
  }



  void deleteUser({required UserResponse user}) async {
    await subaInstance.from('users').delete().eq('email', user.user!.email!);
    await subaInstance.auth.admin.deleteUser(user.user!.id);
  }
}
