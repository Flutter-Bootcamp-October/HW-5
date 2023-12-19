import 'package:supabase/supabase.dart';

class SupaBaseIntegration {
  static late SupabaseClient subaInstance;
  get supabase {
    final supabase = SupabaseClient("https://adkikwpderxcmaqwdcyb.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFka2lrd3BkZXJ4Y21hcXdkY3liIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTc3NzI4MCwiZXhwIjoyMDE1MzUzMjgwfQ.3PZEk6i-YLeE_yMTbeBWqXYgKtSS-DS5sJW_KJMpPq4");
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

  void updateFromTable(
      {required String tableName,
      required Map<String, dynamic> body,
      required UserResponse user}) async {
    body.addAll({'user_id': user.user!.id});
    await subaInstance.from(tableName).upsert(body, onConflict: 'user_id');
  }

  void deleteUser({required UserResponse user}) async {
    await subaInstance.from('profile').delete().eq('user_id', user.user!.id);
    await subaInstance.from('users').delete().eq('user_id', user.user!.id);
    await subaInstance.auth.admin.deleteUser(user.user!.id);
  }
}
