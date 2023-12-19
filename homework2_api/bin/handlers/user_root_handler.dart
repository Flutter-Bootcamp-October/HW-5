import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../config/supabase.dart';

signupUser(Request req) async {
  try {
    final Map<String, dynamic> body = jsonDecode(await req.readAsString());
    final supabase = SupabaseClass.intense;

    if (!body.containsKey("email")) {
      return Response.badRequest(body: "please enter email");
    }
    if (!body.containsKey("password")) {
      return Response.badRequest(body: "please enter password");
    }
    if (!body.containsKey("name")) {
      return Response.badRequest(body: "name");
    }
    if (body.length > 3) {
      return Response.badRequest(body: "please remove the extra keys");
    }
    AuthResponse? user;
    await supabase?.auth.admin
        .createUser(AdminUserAttributes(
            email: body["email"],
            password: body["password"],
            emailConfirm: true))
        .then((value) async {
      user = await supabase.auth
          .signInWithPassword(password: body["password"], email: body["email"]);
      body.remove("password");
      body.addAll({"UUID": user?.user?.id});
      await supabase.from("user").insert(body);
    });
    return Response.ok("success signup: \n${user!.session?.accessToken}");
  } catch (e) {
    return Response.badRequest(body: "error $e");
  }
}

loginUser(Request req) async {
  try {
    AuthResponse? user;
    final supabase = SupabaseClass.intense;

    final Map body = jsonDecode(await req.readAsString());

    if (!body.containsKey("email")) {
      return Response.badRequest(body: "please enter email");
    }
    if (!body.containsKey("password")) {
      return Response.badRequest(body: "please enter password");
    }
    if (body.length > 2) {
      return Response.badRequest(body: "please remove the extra keys");
    }

    user = await supabase?.auth
        .signInWithPassword(password: body["password"], email: body["email"]);

    return Response.ok(jsonEncode({
      "token": user!.session?.accessToken,
      "refresh token": user.session?.refreshToken
    }));
  } catch (e) {
    return Response.badRequest(body: "error $e");
  }
}

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
