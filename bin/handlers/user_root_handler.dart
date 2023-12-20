import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../config/supabase.dart';

userProfile(Request req) async {
  try {
    final supabase = SupabaseClass.intense;

    final Map body = jsonDecode(await req.readAsString());

    if (!body.containsKey("email")) {
      return Response.badRequest(body: "please enter email");
    }

    await supabase?.from("user").update(body).eq("email", body["email"]);
    return Response.ok("Success");
  } catch (e) {
    return Response.badRequest(body: "error $e");
  }
}

getUserProfile(Request req) async {
  try {
    final supabase = SupabaseClass.intense;

    final Map body = jsonDecode(await req.readAsString());

    if (!body.containsKey("email")) {
      return Response.badRequest(body: "please enter email");
    }
    if (body.length > 1) {
      return Response.badRequest(body: "please remove the extra keys");
    }
    final user =
        await supabase?.from("user").select().eq("email", body["email"]);
    final id =
        await supabase?.from("user").select("UUID").eq("email", body["email"]);
    print(id);
    if (user!.isNotEmpty) {
      return Response.ok(jsonEncode(user[0]));
    }
    return Response.badRequest(body: "the email is not exists");
  } catch (e) {
    return Response.badRequest(body: "error $e");
  }
}

deleteAccount(Request req) async {
  try {
    final supabase = SupabaseClass.intense;

    final Map body = jsonDecode(await req.readAsString());

    if (!body.containsKey("email")) {
      return Response.badRequest(body: "please enter email");
    }
    if (body.length > 1) {
      return Response.badRequest(body: "please remove the extra keys");
    }
    final id =
        await supabase?.from("user").select("UUID").eq("email", body["email"]);
    await supabase?.from("user").delete().eq("email", body["email"]);

    if (id!.isNotEmpty) {
      await supabase?.auth.admin.deleteUser(id[0]["UUID"]);
      return Response.ok("The account deleted successfully");
    }

    return Response.badRequest(body: "the email is not exists");
  } catch (e) {
    return Response.badRequest(body: "error $e");
  }
}
