import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../config/supabase_config.dart';

deleteHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final supabase = SupabaseIntegration.instant;
    await supabase!.from("users").delete().eq("email", body["email"]);
    return Response.ok("Your account delete successfully");
  } on PostgrestException catch (error) {
    return Response.badRequest(body: error.message);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
