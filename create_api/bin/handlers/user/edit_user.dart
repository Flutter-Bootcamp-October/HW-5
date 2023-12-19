import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../configs/supabase.dart';
import '../../helper/check_userdate.dart';

updateUser(Request request) async {
  try {
    List<String> key = ["username", "phone"];
    final Map body = jsonDecode(await request.readAsString());
    final user = SupabaseNet.supabases;
    final id =
        await SupabaseNet.supabases!.auth.getUser(request.headers["token"]);
    await checkuser(key: key, body: body);
    final getUser = await user
        ?.from("user_api")
        .update(body)
        .eq("id_auth", id.user!.id.toString())
        .select();
    print(getUser);
    return Response.ok(jsonEncode(getUser),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (e) {
    return Response.badRequest(
        body: jsonEncode({"meg": e.message}),
        headers: {"Content-Type": "application/json"});
  } catch (e) {
    return Response.badRequest(
        body: jsonEncode({"meg": "token is invalid"}),
        headers: {"Content-Type": "application/json"});
  }
}
