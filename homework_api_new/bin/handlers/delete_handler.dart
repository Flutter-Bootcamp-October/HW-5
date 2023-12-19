import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../database/supabase.dart';

deleteHandler(Request req) async {
  if (req.headers["token"] != null) {
    try {
      UserResponse user =
          await SupaServices().supa.auth.getUser(req.headers["token"]);
      final profile = await SupaServices()
          .supa
          .from("users")
          .select()
          .eq("email", user.user!.email!);
      await SupaServices()
          .supa
          .from("users")
          .delete()
          .eq("id", profile[0]["id"]);
      await SupaServices()
          .supa
          .from("profiles")
          .delete()
          .eq("id", user.user!.id);
      await SupaServices().supa.auth.admin.deleteUser(user.user!.id);
      return Response.ok("deleted successfuly");
    } catch (error) {
      return Response.badRequest(body: error.toString());
    }
  } else {
    return Response.badRequest(body: "request is missing token");
  }
}
