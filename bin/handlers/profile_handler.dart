import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../services/supabase_configretion.dart';

profile(Request req) async {
  try {
    final supabase = SupabaseConfigretion.supabase;
    final profile = await supabase
        .from('user')
        .select()
        .eq('id', supabase.auth.currentUser!.id);
    return Response.ok(
        jsonEncode({
          "name": profile.first['name'],
          "email": profile.first['email'],
          "bio": profile.first['bio'],
        }),
        headers: {"Content-Type": "application/json"});
  } catch (error) {
    return Response.unauthorized(jsonEncode({"msg": "Error!"}));
  }
}
